Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx49lHoH242AO9DncjcR0YVSFZZA3zF1SEbgRSddyRxPVh0H4KgspJ0sJ9rz4ktttCnscDz0Q
ARC-Seal: i=1; a=rsa-sha256; t=1524653024; cv=none;
        d=google.com; s=arc-20160816;
        b=BT/qWGaeFDbaqX06KHx+vB1ycf/aXp9fSAtr1Cjrdf942M8x6NZhLaYd6tXt5WxodC
         uygfUkMpiodXVS4dcZvCcY2aMSnzKluydMd4K48IlgGohZIVT90ad/VDsyeL25YD4Nj4
         u5WvlpS733iZJZUSBtDDpt98tz83wu7JkLzU1BcswpPbZOAGr51a4vGlcbBwuwZSygxN
         KineB1Q6tcXjI6c9aCp6BlNnfC3C3T/kwrjdpt3Y+bMBj3LaoMpaI1FlyBZ693C6syTX
         nUD5gGgi+lLng0+mP/VVARpD4lxcZ7IDnOtjlqKQ6MHvFqsK3p4LWkl9SDj0xbeVEu6F
         uqHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=FSa3NE3/If0g6mUnYqQ3r0Od3QLCLrt63nowtIYYTpY=;
        b=Ijl03A31wSXhTGZyFN5TZSlz+9YsPki6ZjRmsqnFM6ybyFVkMq4k/X5B69x8F/NzA3
         +eyAJzOX4KpNzvgPa+LibdDmYf3XX8ycvSu2efpJb5d60T+RQFZEa0cLg0SGoLx/DqxT
         ipOKxYNnMTZuoahUVYeT5PujQZsX6cd/2KxNZ1plaIBR9d3cc2PER0XlIeTtXmKoPSeN
         wLagDPzKOfy9nwQkI5Xp/0TgitNTQynmcYaNtVjN6NK3LIQOqk2+8/MMc8sosu0GnIYz
         jN24HKXTbtOlQLg4+ouRm+/IX6z76DwzHZx2t+Em24Iihex3d/k1BTZaEiV1UvRHw0To
         0amg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	David Gibson <david@gibson.dropbear.id.au>,
	Paul Mackerras <paulus@ozlabs.org>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 157/183] KVM: PPC: Book3S HV: Fix handling of secondary HPTEG in HPT resizing code
Date: Wed, 25 Apr 2018 12:36:17 +0200
Message-Id: <20180425103248.849517263@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180425103242.532713678@linuxfoundation.org>
References: <20180425103242.532713678@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598714570272808104?=
X-GMAIL-MSGID: =?utf-8?q?1598714570272808104?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Paul Mackerras <paulus@ozlabs.org>


[ Upstream commit 05f2bb0313a2855e491dadfc8319b7da261d7074 ]

This fixes the computation of the HPTE index to use when the HPT
resizing code encounters a bolted HPTE which is stored in its
secondary HPTE group.  The code inverts the HPTE group number, which
is correct, but doesn't then mask it with new_hash_mask.  As a result,
new_pteg will be effectively negative, resulting in new_hptep
pointing before the new HPT, which will corrupt memory.

In addition, this removes two BUG_ON statements.  The condition that
the BUG_ONs were testing -- that we have computed the hash value
incorrectly -- has never been observed in testing, and if it did
occur, would only affect the guest, not the host.  Given that
BUG_ON should only be used in conditions where the kernel (i.e.
the host kernel, in this case) can't possibly continue execution,
it is not appropriate here.

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
Signed-off-by: Paul Mackerras <paulus@ozlabs.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/powerpc/kvm/book3s_64_mmu_hv.c |    8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

--- a/arch/powerpc/kvm/book3s_64_mmu_hv.c
+++ b/arch/powerpc/kvm/book3s_64_mmu_hv.c
@@ -1348,12 +1348,8 @@ static unsigned long resize_hpt_rehash_h
 	}
 
 	new_pteg = hash & new_hash_mask;
-	if (vpte & HPTE_V_SECONDARY) {
-		BUG_ON(~pteg != (hash & old_hash_mask));
-		new_pteg = ~new_pteg;
-	} else {
-		BUG_ON(pteg != (hash & old_hash_mask));
-	}
+	if (vpte & HPTE_V_SECONDARY)
+		new_pteg = ~hash & new_hash_mask;
 
 	new_idx = new_pteg * HPTES_PER_GROUP + (idx % HPTES_PER_GROUP);
 	new_hptep = (__be64 *)(new->virt + (new_idx << 4));

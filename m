Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELtweI52frpm9ZmzgfXDg1WWYn57dpf1zEuonpMKmXVUioyLqtBBCvxLHip9YhRscHGWgCOV
ARC-Seal: i=1; a=rsa-sha256; t=1521483455; cv=none;
        d=google.com; s=arc-20160816;
        b=NAvZtQexXUOuJWoCxtN9mFDhORWW2jf5H5WygfSdtv9i5E1rKaAllQbxxNPzzprZbC
         U6HX7tut8eTckoD015dBAfTogcW5wS58Fwk8z9BznE0+zfV/MIoUEnS9kJxpcyd0LqeZ
         FyLk6ftCqHz6xmutL2V0yjVBSW+EI/Vy9/pd752JrBBavx7jc98Ny5uzF5piKC0bY0oi
         ADh60tmVL7CQr+DgJ7GaXRs2TVJLSjvtccrjmyfWColGO/9yfLKlkdEF2lPIXYrQpCuv
         2/wcgnBLb/jJW21Gy7y70neFIqRYj6eBRPqSfB/ipY5xWQ25HDh+eBky5O8chLMviOxr
         Oo2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=J7PC1jB9UdlkvFyNp2JKfFxgAsx18T3TxAoE15JDv3Q=;
        b=UunPjXy/Sxq6kdZePP99+vjUI/ziMwIDvlnk5v667ikTKKiPY6K1ChrOAFSYSbamuA
         Bxec0Fb7CGYM6C7u1RZGCQ6q80LVco+k8kwibFV6AXcAA5Ux/H3RReYP3jdjWyzEWCG/
         kem06rH6uy9Np3kSgtFFQqhVTcRrlwmfHl/Av5F28REy5dTAEiWtK9uQnv63YD3wI0C/
         F8P5qVjYT7NhisaKH5gfMoymcsr6+dEo0ARtNypZHSWCVhsd0LgNfudp+ijcBdY4/Lo4
         yHv+Ri5c8+21zI41Zh8stkSMO9fB8MFjLNDFfvWy8nwdNuQg4xVjqP+xIsXUTE4DGhnO
         wblA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Naohiro Aota <naohiro.aota@wdc.com>,
	Hans van Kranenburg <hans.van.kranenburg@mendix.com>,
	David Sterba <dsterba@suse.com>
Subject: [PATCH 4.4 130/134] btrfs: alloc_chunk: fix DUP stripe size handling
Date: Mon, 19 Mar 2018 19:06:53 +0100
Message-Id: <20180319171908.027816489@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319171849.024066323@linuxfoundation.org>
References: <20180319171849.024066323@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595391036259141384?=
X-GMAIL-MSGID: =?utf-8?q?1595391036259141384?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hans van Kranenburg <hans.van.kranenburg@mendix.com>

commit 92e222df7b8f05c565009c7383321b593eca488b upstream.

In case of using DUP, we search for enough unallocated disk space on a
device to hold two stripes.

The devices_info[ndevs-1].max_avail that holds the amount of unallocated
space found is directly assigned to stripe_size, while it's actually
twice the stripe size.

Later on in the code, an unconditional division of stripe_size by
dev_stripes corrects the value, but in the meantime there's a check to
see if the stripe_size does not exceed max_chunk_size. Since during this
check stripe_size is twice the amount as intended, the check will reduce
the stripe_size to max_chunk_size if the actual correct to be used
stripe_size is more than half the amount of max_chunk_size.

The unconditional division later tries to correct stripe_size, but will
actually make sure we can't allocate more than half the max_chunk_size.

Fix this by moving the division by dev_stripes before the max chunk size
check, so it always contains the right value, instead of putting a duct
tape division in further on to get it fixed again.

Since in all other cases than DUP, dev_stripes is 1, this change only
affects DUP.

Other attempts in the past were made to fix this:
* 37db63a400 "Btrfs: fix max chunk size check in chunk allocator" tried
to fix the same problem, but still resulted in part of the code acting
on a wrongly doubled stripe_size value.
* 86db25785a "Btrfs: fix max chunk size on raid5/6" unintentionally
broke this fix again.

The real problem was already introduced with the rest of the code in
73c5de0051.

The user visible result however will be that the max chunk size for DUP
will suddenly double, while it's actually acting according to the limits
in the code again like it was 5 years ago.

Reported-by: Naohiro Aota <naohiro.aota@wdc.com>
Link: https://www.spinics.net/lists/linux-btrfs/msg69752.html
Fixes: 73c5de0051 ("btrfs: quasi-round-robin for chunk allocation")
Fixes: 86db25785a ("Btrfs: fix max chunk size on raid5/6")
Signed-off-by: Hans van Kranenburg <hans.van.kranenburg@mendix.com>
Reviewed-by: David Sterba <dsterba@suse.com>
[ update comment ]
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/btrfs/volumes.c |   11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -4638,10 +4638,13 @@ static int __btrfs_alloc_chunk(struct bt
 	if (devs_max && ndevs > devs_max)
 		ndevs = devs_max;
 	/*
-	 * the primary goal is to maximize the number of stripes, so use as many
-	 * devices as possible, even if the stripes are not maximum sized.
+	 * The primary goal is to maximize the number of stripes, so use as
+	 * many devices as possible, even if the stripes are not maximum sized.
+	 *
+	 * The DUP profile stores more than one stripe per device, the
+	 * max_avail is the total size so we have to adjust.
 	 */
-	stripe_size = devices_info[ndevs-1].max_avail;
+	stripe_size = div_u64(devices_info[ndevs - 1].max_avail, dev_stripes);
 	num_stripes = ndevs * dev_stripes;
 
 	/*
@@ -4681,8 +4684,6 @@ static int __btrfs_alloc_chunk(struct bt
 			stripe_size = devices_info[ndevs-1].max_avail;
 	}
 
-	stripe_size = div_u64(stripe_size, dev_stripes);
-
 	/* align to BTRFS_STRIPE_LEN */
 	stripe_size = div_u64(stripe_size, raid_stripe_len);
 	stripe_size *= raid_stripe_len;

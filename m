Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x225KP83NX59S8Y/t38/OSwsmKemxMZnjZfHGiFXsq/8eKT3KcmRTjmgy15FHDXpl94/xkfRF
ARC-Seal: i=1; a=rsa-sha256; t=1518709153; cv=none;
        d=google.com; s=arc-20160816;
        b=K286J8SFbuyU5+9J9Zii5a4CmW0CUFoYzSBn2NnUsV1zrY0XURNhayCNwOF6oyn1ju
         ZqkT0UChElFC7xEtnkAETL51AWI5wDPRINqBfLxr2jugbTuIc7RhUdgFg+Uka9ENtrCF
         HwkNIbzczwbuGt9BxVj9M32ACGA18Hnx4EIGm7Xz6I3PsEiciZ4ZdflYz+gfWtngcHWt
         MHjoaxio5dXEt1sih+JQR24wpcu1SjREZGVheO77ecPSE6VgRLjNDTKwp2fOxmQhSxsM
         T2iNge7hbf9sk26AmSKkuSqNwPDK9+WR0Y9kPhm7zwkZ8mKe3Uh4z8LK1GxvxhEXHnvO
         G65Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=93SoG/E3saCvT920AAhOu5tKUnwUlbCMcY8XFut1h0Q=;
        b=djgsAV59a91k6KoKfBgNQImECE1Qosy/oNH21n28TtSt5PX/FpAXM7qunB7G3+7A1m
         8j4dZrE6L6JIStx+EEUsYZOBPEarUljy2XghJ8NHqWZrP5PQ/isvAcoR7Zj/RPsEta6l
         5RPUPPGBM/jNfYDpYV/DFxoQf/6cu2wkEve4fE21XljiTy1k/QjBhM8cV1H40RmRxkUs
         ECo5UtyYyT6CQ41zQj+Nyz5IKK/Vuqn0XKvBGS7MvR3NBpFB6D2rOL+P6ep+Wr2G8ZLk
         ZdulmFKUF/ofjqkyo9YH/nlFSLgL1K9L9IzignBVQlXKuZ9S1BO+nzaMIXdLKEBrr1Fz
         NRYA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Mark Rutland <mark.rutland@arm.com>,
	Laura Abbott <labbott@redhat.com>,
	Shanker Donthineni <shankerd@codeaurora.org>,
	Will Deacon <will.deacon@arm.com>
Subject: [PATCH 4.15 016/202] [Variant 3/Meltdown] arm64: mm: Temporarily disable ARM64_SW_TTBR0_PAN
Date: Thu, 15 Feb 2018 16:15:16 +0100
Message-Id: <20180215151713.700527466@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151712.768794354@linuxfoundation.org>
References: <20180215151712.768794354@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1592481423799436656?=
X-GMAIL-MSGID: =?utf-8?q?1592481969539744948?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Will Deacon <will.deacon@arm.com>


Commit 376133b7edc2 upstream.

We're about to rework the way ASIDs are allocated, switch_mm is
implemented and low-level kernel entry/exit is handled, so keep the
ARM64_SW_TTBR0_PAN code out of the way whilst we do the heavy lifting.

It will be re-enabled in a subsequent patch.

Reviewed-by: Mark Rutland <mark.rutland@arm.com>
Tested-by: Laura Abbott <labbott@redhat.com>
Tested-by: Shanker Donthineni <shankerd@codeaurora.org>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm64/Kconfig |    1 +
 1 file changed, 1 insertion(+)

--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -920,6 +920,7 @@ endif
 
 config ARM64_SW_TTBR0_PAN
 	bool "Emulate Privileged Access Never using TTBR0_EL1 switching"
+	depends on BROKEN       # Temporary while switch_mm is reworked
 	help
 	  Enabling this option prevents the kernel from accessing
 	  user-space memory directly by pointing TTBR0_EL1 to a reserved

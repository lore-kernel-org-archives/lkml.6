Return-Path: <npiggin@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1525100169; cv=none;
        d=google.com; s=arc-20160816;
        b=xviiPM8uBWobANQ9oJ3QkyS+bRik/+J7BW5sQjuBw0cUGb8yiykV/bu2miq3rse4LO
         kT8Bxl/Jw7j99o3YcJ/5TLYgsdC+PnRySL7CX62rJdMp389zvGG+r1xxUEzUNgWKxpXh
         6EEigmzi0GU+mzK9KXl5GxKEvnCM8dwQJyce69UcgDpRbCz4C7trVzxfdBHQhGuz+pDN
         f36mlMIAL1y7uOcgvyteRVakhLBBKV8+nWGtjOMoTsMeoqDH838Gwib1BDBgN7/Rc7BS
         UCfgSB2P55Jp99gHuBAbNpOj2l6rxxmN/yEtQ9moJrFrFrLJJR10/EYiaQfH/SLiXiY6
         2pYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=ocO7Yk13OYCSN4eCYPhuRJ29wJp1e1v9UBvMeP671W0=;
        b=ujgUXgI8IJYzNHCYkr5EbQ7ZLnHbLLRYxgO2sdVtQ1z1+07u7b7Xd1seA2+q7RAxjg
         A/hul1r0vrWnvGiDN/g4yLCsnu+4I9k8SBTBTIsqyjyAHCNV/h+XGtZMFJgeUGG8b/sY
         sUcADmQwLgIWI5OaJ2w+/wtmiqwV3ZCmDhSGLmdw6BncAEu6988MM80aXuG3NYcHZglh
         CIMxd/ze3JK3YiOwGCnIVsCE2R5eqrjQ1VDW94relWnVnYmirhZSTC0vhUhRGtR+jcuN
         FJVtfHxhrCS1K8ukJ+RlTtrxMzQgzR+XTwqkSRyabW3FTx+VomuD5en50WJYY4tv8Iu7
         RnZw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=pVbNruL2;
       spf=pass (google.com: domain of npiggin@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=npiggin@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=pVbNruL2;
       spf=pass (google.com: domain of npiggin@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=npiggin@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AB8JxZo8vTcdS6Tp63Pj4hO1eWjYJpKFnRp+r9Vnc9tDnaSu5+pxfUIz6Akw2t6/xzjE1qzKtIcuvw==
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jslaby@suse.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 00/15] hvc and powerpc opal console latency reduction
Date: Tue,  1 May 2018 00:55:43 +1000
Message-Id: <20180430145558.4308-1-npiggin@gmail.com>
X-Mailer: git-send-email 2.17.0
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599183434800910372?=
X-GMAIL-MSGID: =?utf-8?q?1599183434800910372?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

I'm seeing scattered reports of hard lockups triggering in the OPAL
console code. I haven't got a full latency trace -- they are difficult
to reproduce and sometimes just show up in dmesg of a bug report when
the system is having other issues. But it does seem like there are
some improvements that can be made to the hvc console and powerpc
opal driver.

I'm not sure how this series should be merged yet, but we can cross
that if/when it comes. Possibly all can go via the tty tree with
acks from powerpc maintainers.

Comments appreciated.

Thanks,
Nick

--
Nicholas Piggin (15):
  powerpc/powernv: opal_put_chars partial write fix
  powerpc/powernv: Fix OPAL console driver OPAL_BUSY loops
  powerpc/powernv: opal-kmsg standardise OPAL_BUSY handling
  powerpc/powernv: opal-kmsg use flush fallback from console code
  powerpc/powernv: Implement and use opal_flush_console
  powerpc/powernv: Remove OPALv1 support from opal console driver
  powerpc/powernv: move opal console flushing to udbg
  powerpc/powernv: implement opal_put_chars_atomic
  tty: hvc: remove unexplained "just in case" spin delay
  tty: hvc: use mutex instead of spinlock for hvc_structs lock
  tty: hvc: hvc_poll break hv read loop
  tty: hvc: hvc_poll may sleep
  tty: hvc: hvc_write may sleep
  tty: hvc: introduce the hv_ops.flush operation for hvc drivers
  powerpc/powernv: provide a console flush operation for opal hvc driver

 arch/powerpc/include/asm/opal.h            |   3 +
 arch/powerpc/platforms/powernv/opal-kmsg.c |  30 +---
 arch/powerpc/platforms/powernv/opal.c      | 176 +++++++++++++------
 drivers/tty/hvc/hvc_console.c              | 194 +++++++++++++--------
 drivers/tty/hvc/hvc_console.h              |   1 +
 drivers/tty/hvc/hvc_opal.c                 |  33 ++--
 6 files changed, 276 insertions(+), 161 deletions(-)

-- 
2.17.0

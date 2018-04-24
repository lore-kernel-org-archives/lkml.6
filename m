Return-Path: <kernel-hardening-return-13128-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AB8JxZoVV6dd/BH0854UL7m4G93y+Uu+QCuE6xO6sfbrmjSeql0HHxZRQ3qmaLWPKF/MaaKXfqfN
ARC-Seal: i=1; a=rsa-sha256; t=1524614296; cv=none;
        d=google.com; s=arc-20160816;
        b=E/K85oSYw51Zo+TZ44YrGsmqbL9OrpjMAgBG0BnV5DWd6u2HfR+5AIuk1c2moMloHz
         OOwpnXw02JG6EE5AJWOGVK7ZyMNFRe16A+ltMTkmzQ11JvEcheASEOlRUQtidbDYH35d
         qRBxMeMi6yCFyZ8RSt2wa7kfG/kLqBWv7DYtJsiZ59dzzRjFnoO6cQC0Fh6dojUeVlVQ
         S+XeWWjxVEO+yOUdJnbYh1Q65dGS1Iq9v6e+0kL/XaglI30XCyEF+m2raPmKoPy8cjLg
         5QAZvbHBrDxZy/yNWqNLVdxFJxeyZt9sDInepxW0Xg66Ff9mQfjRlhsZZ08pRSKF4/Lc
         OG7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :dkim-signature:delivered-to:list-id:list-subscribe:list-unsubscribe
         :list-help:list-post:precedence:mailing-list
         :arc-authentication-results;
        bh=P4OR2bs8LOOyKBUaIeannur0COHiKggc9aW5OIwEC7U=;
        b=XR8ogGt0wNLVJpQLyIrmv8zppbqCoth2WSXofXOt8Iy8YvqAIO1uUDcTCWCSIo4a1X
         FUqJ5ftrFD50wF6AIbTvLmk21voT0udleUYgNmJSeDblSmfioOQOpt6rWlH3t1JTsHxq
         JpHqDDagKzi/EyDdmc+NrRA3etbJaIFtTkOW19RUvRumJHv1oFSWFPKfCNZDgAgSfuCk
         WX+mMdZmZEh2cGSZMVZI48pL0QVwgxtbVL2FjHvTPiCNFFXD9scvK3cNM3fDzt/pKvyt
         e0ba6YU9DhUvh9CmCQMDTMuIYC58CIsE+Ao55sSYfIwOIHam32isYLv7kl3SbG/ubBvj
         TV9g==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@chromium.org header.s=google header.b=E+MD8UJM;
       spf=pass (google.com: domain of kernel-hardening-return-13128-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-13128-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@chromium.org header.s=google header.b=E+MD8UJM;
       spf=pass (google.com: domain of kernel-hardening-return-13128-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-13128-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Date: Tue, 24 Apr 2018 16:57:52 -0700
From: Kees Cook <keescook@chromium.org>
To: Kalle Valo <kvalo@codeaurora.org>
Cc: Andreas Christoforou <andreaschristofo@gmail.com>,
	Rosen Penev <rosenp@gmail.com>,
	Eric Dumazet <eric.dumazet@gmail.com>,
	Joe Perches <joe@perches.com>, linux-wireless@vger.kernel.org,
	netdev@vger.kernel.org,
	QCA ath9k Development <ath9k-devel@qca.qualcomm.com>,
	kernel-hardening@lists.openwall.com, linux-kernel@vger.kernel.org
Subject: [PATCH v3] ath9k: dfs: Remove VLA usage
Message-ID: <20180424235752.GA37317@beast>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598673960782559388?=
X-GMAIL-MSGID: =?utf-8?q?1598673960782559388?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

In the quest to remove all stack VLA usage from the kernel[1], this
redefines FFT_NUM_SAMPLES as a #define instead of const int, which still
triggers gcc's VLA checking pass.

[1] https://lkml.org/lkml/2018/3/7/621

Co-developed-by: Andreas Christoforou <andreaschristofo@gmail.com>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
v3: replace FFT_NUM_SAMPLES as a #define (Joe)
---
 drivers/net/wireless/ath/ath9k/dfs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ath/ath9k/dfs.c b/drivers/net/wireless/ath/ath9k/dfs.c
index 6fee9a464cce..e6e56a925121 100644
--- a/drivers/net/wireless/ath/ath9k/dfs.c
+++ b/drivers/net/wireless/ath/ath9k/dfs.c
@@ -40,8 +40,8 @@ static const int BIN_DELTA_MIN		= 1;
 static const int BIN_DELTA_MAX		= 10;
 
 /* we need at least 3 deltas / 4 samples for a reliable chirp detection */
-#define NUM_DIFFS 3
-static const int FFT_NUM_SAMPLES	= (NUM_DIFFS + 1);
+#define NUM_DIFFS	3
+#define FFT_NUM_SAMPLES	(NUM_DIFFS + 1)
 
 /* Threshold for difference of delta peaks */
 static const int MAX_DIFF		= 2;
-- 
2.7.4


-- 
Kees Cook
Pixel Security

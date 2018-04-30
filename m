Return-Path: <npiggin@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1525100172; cv=none;
        d=google.com; s=arc-20160816;
        b=mDLCtV9otnh7TvRdywwhvBoFNAu6AC0q5AmMUcfTOtE9NxpObgQwkw3wcX0HRyVlVc
         VwdWNJogCzrnqEuj4kniXTjri0Mnh7NmVT1KvhebPfNpRB4010/ddiPk6+/UWsMXZDXr
         XTztcGnOS3tINxX0hinWrMKe06VczS+8Y5njd7He1LT7lEA1zYNiFopblsei+zDQMGVq
         kCJtormZ2X41mYcB20uwqrpe5inOosRrilLFKazedr0OCLA3ItnRjkFgpXciomkflDcX
         Q3qj/R23hhS4enJKu+rB27awMBrMyC03a+z4EG0LEii+pE9p9dUnoIjotL4nqpOc8p5k
         IzNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=Un0p1Eukz+1AlGLfbig1HwEh7qdLym2j7MsHl3FR87c=;
        b=c08hsCRLIrc2wXjOFEpAguPrEoMWO+msDp3ThXDYofjj6f2+E2hFpR19B+guW1bhQo
         U+vbLeuB68D0TWy2AJVFexjtCKTti62Y3XH1Bppq1e1AFm3ovsreXPTKFnHx0zmHGTmg
         rKsvN8ScFDTPsFPSTtaqvVnuUAJbldY8nZTTUdM+f5gVm+3hdD8e3EsqDNPH5HlWAFyY
         nYeNxoZ5ugWBZWoatOgaBXkdWEXLcJgA85kz44a12Pri7J8kMtDe/9wFtZKQLNzRgO7b
         fIXoKCxVbu9I8odSC8DviIORRldfMMlGvVwmEBpgMPDhk/du08K+D2PHWHw7V2S7/79i
         UoqQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=A8XcqWPk;
       spf=pass (google.com: domain of npiggin@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=npiggin@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=A8XcqWPk;
       spf=pass (google.com: domain of npiggin@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=npiggin@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AB8JxZopSZ99a4kci+KS/caLlCcpkANsSs1IiqoUyY+QvSmACl9/yyLm0yTRgS40eO3bn7/BqX7cag==
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jslaby@suse.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 01/15] powerpc/powernv: opal_put_chars partial write fix
Date: Tue,  1 May 2018 00:55:44 +1000
Message-Id: <20180430145558.4308-2-npiggin@gmail.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180430145558.4308-1-npiggin@gmail.com>
References: <20180430145558.4308-1-npiggin@gmail.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599183439096619694?=
X-GMAIL-MSGID: =?utf-8?q?1599183439096619694?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The intention here is to consume and discard the remaining buffer
upon error. This works if there has not been a previous partial write.
If there has been, then total_len is no longer total number of bytes
to copy. total_len is always "bytes left to copy", so it should be
added to written bytes.

This code may not be exercised any more if partial writes will not be
hit, but this is a small bugfix before a larger change.

Reviewed-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/platforms/powernv/opal.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/powernv/opal.c b/arch/powerpc/platforms/powernv/opal.c
index 48fbb41af5d1..e695b836fd49 100644
--- a/arch/powerpc/platforms/powernv/opal.c
+++ b/arch/powerpc/platforms/powernv/opal.c
@@ -388,7 +388,7 @@ int opal_put_chars(uint32_t vtermno, const char *data, int total_len)
 		/* Closed or other error drop */
 		if (rc != OPAL_SUCCESS && rc != OPAL_BUSY &&
 		    rc != OPAL_BUSY_EVENT) {
-			written = total_len;
+			written += total_len;
 			break;
 		}
 		if (rc == OPAL_SUCCESS) {
-- 
2.17.0

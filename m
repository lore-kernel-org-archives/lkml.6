Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x226HTE5B4By0ZSxU2ap8Zao1iBMS4inOk+qsHBFsXcuCSD8MnzNhLCwe3bZ7ZqLbVMAhP8g2
ARC-Seal: i=1; a=rsa-sha256; t=1519411209; cv=none;
        d=google.com; s=arc-20160816;
        b=cbaSqRHTsq1LcpVyVB3+6q/ISiY5M+YcrfTSudgth+sIGyScBrlhfXUu4WcoMUyqJA
         8s6GRTLUdgQzo4IhGYLQYFtkpZJgmfAr5nZ2UAClqPWga8iWX1XewKHrAmAHrZv+Ouwq
         n0E1fyXiiiFNPCPv5j9B09+CHb79eN8b43MUaEs6eG92pC14TiJnpSDdL7Zyldh/oWiV
         zru96odsHB6xJNdcFcqipDS/6Gav7EpmJ+cwO0JSoKN14J1nu+LCVc+zQ5/CVBR54g2N
         NJLrZg/6tE4gGS+dDL9/rdKYReiWd61GHERWxCFpdnlBov/46LVCQXV16YDA3sawIXsA
         JbTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=zTw9YvvKse1l+CeQk9Q0TnIDnnHNhh2Q95Vc5CpA1UU=;
        b=A4mD+CWF9QLu5c5Ww3CeBa477fejDoG0lakRFL4YiZqwFvJHBBPcQLEG2vndmUDPas
         pMzTtjRQG0scjMzN1r+MjsSOq4G3F93f7tt/Sox9eviVUVxGAV0Q4F/Yx/ZwzkrwXVKv
         VcaTxY1+jByMEuOIg0wxXzb6ohaD8dIf/ZsoANH+1JL0GSZ+SnQX0rVCVEfNL1VG6pg+
         r5TLCCYgTVNHqP+SRqkFO8nHD3ohHELsUb4cE7dno9WFQPdYib4FL9eYbl6fG4qPFdyy
         dSpUq8XdonIVwcbtgFQFvzVDwr8jCMDQsQTBbZ0LxCkGFhme2A7Jiwv1mqHycq0d7S8Y
         o/AA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Paul Bolle <pebolle@tiscali.nl>,
	Joe Perches <joe@perches.com>,
	Daniel Vetter <daniel.vetter@ffwll.ch>
Subject: [PATCH 4.4 121/193] drm/vmwgfx: use *_32_bits() macros
Date: Fri, 23 Feb 2018 19:25:54 +0100
Message-Id: <20180223170344.839674678@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170325.997716448@linuxfoundation.org>
References: <20180223170325.997716448@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593218128204380669?=
X-GMAIL-MSGID: =?utf-8?q?1593218128204380669?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Paul Bolle <pebolle@tiscali.nl>

commit 0e7c875d1ae9dcf4d8c6018a45e5529feaef8956 upstream.

Use the upper_32_bits() macro instead of the four line equivalent that
triggers a GCC warning on 32 bits x86:
    drivers/gpu/drm/vmwgfx/vmwgfx_cmdbuf.c: In function 'vmw_cmdbuf_header_submit':
    drivers/gpu/drm/vmwgfx/vmwgfx_cmdbuf.c:297:25: warning: right shift count >= width of type [-Wshift-count-overflow]
       val = (header->handle >> 32);
                             ^

And use the lower_32_bits() macro instead of and-ing with a 32 bits
mask.

Signed-off-by: Paul Bolle <pebolle@tiscali.nl>
Acked-by: Joe Perches <joe@perches.com>
Signed-off-by: Daniel Vetter <daniel.vetter@ffwll.ch>
Link: http://patchwork.freedesktop.org/patch/msgid/1457000770-2317-1-git-send-email-pebolle@tiscali.nl
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/vmwgfx/vmwgfx_cmdbuf.c |    7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

--- a/drivers/gpu/drm/vmwgfx/vmwgfx_cmdbuf.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_cmdbuf.c
@@ -293,13 +293,10 @@ static int vmw_cmdbuf_header_submit(stru
 	struct vmw_cmdbuf_man *man = header->man;
 	u32 val;
 
-	if (sizeof(header->handle) > 4)
-		val = (header->handle >> 32);
-	else
-		val = 0;
+	val = upper_32_bits(header->handle);
 	vmw_write(man->dev_priv, SVGA_REG_COMMAND_HIGH, val);
 
-	val = (header->handle & 0xFFFFFFFFULL);
+	val = lower_32_bits(header->handle);
 	val |= header->cb_context & SVGA_CB_CONTEXT_MASK;
 	vmw_write(man->dev_priv, SVGA_REG_COMMAND_LOW, val);
 

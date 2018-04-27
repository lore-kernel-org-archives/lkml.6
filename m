Return-Path: <SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZqADVlWvrbCiYpWg04wt4fdS/r0stuaJVl78Ug0gURQOmLfKM2fOoV7/1FBp8MWQzZiyaoz
ARC-Seal: i=1; a=rsa-sha256; t=1524838274; cv=none;
        d=google.com; s=arc-20160816;
        b=GoG3rKgcVuuBn++NNL4qF+HIVBQE6QB42KKhGFrFSWZ1kvcrhphdv9+ERCAziHgqVv
         2pDNZNZhdeODKCLcdqjn1aafZKInat2foKfainEpNn+xyMHaFYs/jXs/cixFciDKcNAM
         yHwLcMy5OOPmrJj5Wj/z0GwliAG3LAnyu3mA9L3N+HXeU/2i/nVjZUeM04x615MJoV8S
         l8TQ/JMuZoj8EzUOHCosi9xw0RlKltJwVs/W2XlAIvucaYjo47DbDC7TJWcS99xtGvwq
         pnPLhyeMrjtwiYHUeQhEwFw37NWumEMaURwnb3pZYwaN2APeCVIBwDFrXtIcxCOf9AnJ
         xVrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=cjimlrrUHEQp0vdg+KuaCBuJWNppzBfRORnyeBuD7xs=;
        b=xUVa/FvC0fBofQjSPdda8HOTMqFF/YE8Lb+sN4tDm17sTAL73kxKKJHJ0M79o9PlBQ
         X6HOCzh9AFVodG8IHwF4XwB+gLpEPuf0+bjLJaaNNHTooz7uuP5sm0r5hz6Y1dmLMgPj
         yQasYXYskf4yTKbObbK+dWGf1XTXYrm7IVGQKo60OeL0v9B+q8/xej3+kfBhWKKdTGim
         c1D29yNn2znJUUDYTwFaez63HqtLPNMKgo8wXPThDcgUdCJBaTEtMMAukVe415hNqpzx
         7oHsqd5U8af9ocPtrT8fkHRLYh226AzsY57m68518P7p+V7HsYZTDsEhXGJSk34xrUqa
         UORw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=4/0d=hq=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=4/0d=hq=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E805218BC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Guillaume Nault <g.nault@alphalink.fr>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.16 44/81] l2tp: fix {pppol2tp, l2tp_dfs}_seq_stop() in case of seq_file overflow
Date: Fri, 27 Apr 2018 15:58:46 +0200
Message-Id: <20180427135745.764668138@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180427135743.216853156@linuxfoundation.org>
References: <20180427135743.216853156@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598908818351222196?=
X-GMAIL-MSGID: =?utf-8?q?1598908818351222196?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Guillaume Nault <g.nault@alphalink.fr>


[ Upstream commit 5411b6187adf62909e3b998ac782e722904c7487 ]

Commit 0e0c3fee3a59 ("l2tp: hold reference on tunnels printed in pppol2tp proc file")
assumed that if pppol2tp_seq_stop() was called with non-NULL private
data (the 'v' pointer), then pppol2tp_seq_start() would not be called
again. It turns out that this isn't guaranteed, and overflowing the
seq_file's buffer in pppol2tp_seq_show() is a way to get into this
situation.

Therefore, pppol2tp_seq_stop() needs to reset pd->tunnel, so that
pppol2tp_seq_start() won't drop a reference again if it gets called.
We also have to clear pd->session, because the rest of the code expects
a non-NULL tunnel when pd->session is set.

The l2tp_debugfs module has the same issue. Fix it in the same way.

Fixes: 0e0c3fee3a59 ("l2tp: hold reference on tunnels printed in pppol2tp proc file")
Fixes: f726214d9b23 ("l2tp: hold reference on tunnels printed in l2tp/tunnels debugfs file")
Signed-off-by: Guillaume Nault <g.nault@alphalink.fr>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/l2tp/l2tp_debugfs.c |    5 ++++-
 net/l2tp/l2tp_ppp.c     |    5 ++++-
 2 files changed, 8 insertions(+), 2 deletions(-)

--- a/net/l2tp/l2tp_debugfs.c
+++ b/net/l2tp/l2tp_debugfs.c
@@ -106,8 +106,11 @@ static void l2tp_dfs_seq_stop(struct seq
 		return;
 
 	/* Drop reference taken by last invocation of l2tp_dfs_next_tunnel() */
-	if (pd->tunnel)
+	if (pd->tunnel) {
 		l2tp_tunnel_dec_refcount(pd->tunnel);
+		pd->tunnel = NULL;
+		pd->session = NULL;
+	}
 }
 
 static void l2tp_dfs_seq_tunnel_show(struct seq_file *m, void *v)
--- a/net/l2tp/l2tp_ppp.c
+++ b/net/l2tp/l2tp_ppp.c
@@ -1626,8 +1626,11 @@ static void pppol2tp_seq_stop(struct seq
 		return;
 
 	/* Drop reference taken by last invocation of pppol2tp_next_tunnel() */
-	if (pd->tunnel)
+	if (pd->tunnel) {
 		l2tp_tunnel_dec_refcount(pd->tunnel);
+		pd->tunnel = NULL;
+		pd->session = NULL;
+	}
 }
 
 static void pppol2tp_seq_tunnel_show(struct seq_file *m, void *v)

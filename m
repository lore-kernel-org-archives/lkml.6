Return-Path: <SRS0=XuY6=IF=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZox40tsgCl4Ev0+WfcMfQNqKWG793EClC1bCguDqkXVINs5diyZJ/sj/SZJu/C47ljZrFf7
ARC-Seal: i=1; a=rsa-sha256; t=1526631651; cv=none;
        d=google.com; s=arc-20160816;
        b=hHjIMlZ+ytOoIOp48PlaNFH2nLJioNrzewkE+KM3TGj4ac2LuokCkwyFs1F1hng2+y
         kSKhy/F2w2H2VlpGL+DFvdbvwwxvV52/HPUSbWheI+CVt7/DlbSNKdrd8nPe/RSb2jGJ
         CKbc/IHyGOjhPbwxjDVVqt1up5KRXIK3OcUqGyP3WmDfnURBbvJiAvDazviAr91PM4GZ
         tezEzb2sV2N+ijsTKyoekvPiQlKrklE0XhgAIc6RB0eAOujqUKq2W3l2GLms5CZqQwd5
         hwWJ/23nA18VEhKBaIm9eoWyB8y8/MjGLPSvvcKwvjxWq9BdfO5y8WWXnvlLiAEwh9Tv
         KafQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=D1RTFWiY5uNfrCuW7nxXAjGrDN2x02EghaKzqRmYrO0=;
        b=d3ElhWqyj+btamFrBc2Q7fk2BbXWpNZamQnAzIvgl9YZKajJfAZqZitIY7+vev9EY4
         2vGmMalaV7nWTluY+K0cZkgqwi3693MjWs/0uSAX6s5bFVM7CwDPtSiMQ/ATPtVtuMVr
         uUbAT2nY1Jc68uGf9of0QirHdL3dENuvrJeYMJKAuv3wwLL7EmJJ5sZgnRh1+SNhbUYd
         J/jpMkO2JbL1FxT5xKFCVAS3y/f39+ivw8kkhTZtmwr10QEFGtsvm8X45t/OWGkgfpsg
         tWUKnI9ginYgWhv4aWknYvVbTcTDtF+hIbNOciYcTxTZSVOwELA0dYb73+g/yq60c7pT
         RLbw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=RPT7+Oax;
       spf=pass (google.com: domain of srs0=xuy6=if=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=XuY6=IF=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=RPT7+Oax;
       spf=pass (google.com: domain of srs0=xuy6=if=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=XuY6=IF=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Antony Antony <antony@phenome.org>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Ben Hutchings <ben.hutchings@codethink.co.uk>
Subject: [PATCH 4.14 43/45] xfrm: fix xfrm_do_migrate() with AEAD e.g(AES-GCM)
Date: Fri, 18 May 2018 10:16:00 +0200
Message-Id: <20180518081532.564108882@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180518081530.331586165@linuxfoundation.org>
References: <20180518081530.331586165@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1600789310960304141?=
X-GMAIL-MSGID: =?utf-8?q?1600789310960304141?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Antony Antony <antony@phenome.org>

commit 75bf50f4aaa1c78d769d854ab3d975884909e4fb upstream.

copy geniv when cloning the xfrm state.

x->geniv was not copied to the new state and migration would fail.

xfrm_do_migrate
  ..
  xfrm_state_clone()
   ..
   ..
   esp_init_aead()
   crypto_alloc_aead()
    crypto_alloc_tfm()
     crypto_find_alg() return EAGAIN and failed

Signed-off-by: Antony Antony <antony@phenome.org>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
Cc: Ben Hutchings <ben.hutchings@codethink.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/xfrm/xfrm_state.c |    1 +
 1 file changed, 1 insertion(+)

--- a/net/xfrm/xfrm_state.c
+++ b/net/xfrm/xfrm_state.c
@@ -1345,6 +1345,7 @@ static struct xfrm_state *xfrm_state_clo
 
 	if (orig->aead) {
 		x->aead = xfrm_algo_aead_clone(orig->aead);
+		x->geniv = orig->geniv;
 		if (!x->aead)
 			goto error;
 	}

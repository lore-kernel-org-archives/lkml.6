Return-Path: <SRS0=XuY6=IF=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZoYodjFnlJrjl+v/SRi7ypOvUCb83ajd3i0egYzrl8K+HGbVniQ3c8LS4nHg5UmrndJKE3E
ARC-Seal: i=1; a=rsa-sha256; t=1526631509; cv=none;
        d=google.com; s=arc-20160816;
        b=IaYf/Bi8prUq9C2klZseB+bEDeVsbQa9nrmkSJP6kcFkWWZ1TmrgNLMv2EmSDLkXNe
         Ot4U8IIX55uWUmzrAnFgZvf6LofEPAjyAyLaWRwhpMFkIH6YYk4RjoSCygwcpE3fOCUf
         CBR573OgF612T+A/n0l+D4haLDqxEyDUxj7E+mOmViGd46In4fiypukcYsFzY6LEswMK
         LINoEtVQny6nSixNvJGwGh8otLW4NefNJrLLxo1Nxr5mJwMK9tBz1gXSgvMUQVpAr7QZ
         uKtVLJ9y8nmR2M2lJFytCvSuWinCJ4a17aHVZns5D4xLNtmdfimbA0EVGecwIQ3i7jUI
         UsfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=BE8TzEehG93W7+z94wQQYuDKxUBQWDVobG4EDXybkpM=;
        b=jl/Dh1CkSSZT0CqGpkC75BKL3q1AWdK66BLW2uPxVXfikizHPusLDmg2r+8KjcLGer
         vzMjHbE5gPsZB9mzTdgs0YGM0BQPOIvl1x8tcYIJTzQ+bFBfJ0fDAX+0sgZ+w6xBxt+X
         HIyigt1buDS4KUzAkh2nee0H3Tw2ShwDrP67PdysYnZdTGl5Xfxqe7gsIgPYKxd9gIwC
         aGj2/sF1mtfykLrGoJJN1alw0aumTZOZwfejzdiWrIIOl4zijpqs76sS2O0IfBe26z3v
         Kzr+4TvGPzPDZrTxQgH0nbJ7Ad4K45gQlN7AVYZOaPCPzTORlQlKuN9MJuNxc/8VPv8w
         DGJA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=QS/om3g/;
       spf=pass (google.com: domain of srs0=xuy6=if=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=XuY6=IF=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=QS/om3g/;
       spf=pass (google.com: domain of srs0=xuy6=if=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=XuY6=IF=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Jianwen Ji <jiji@redhat.com>,
	Xin Long <lucien.xin@gmail.com>,
	Neil Horman <nhorman@tuxdriver.com>,
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.16 45/55] sctp: clear the new asocs stream outcnt in sctp_stream_update
Date: Fri, 18 May 2018 10:15:41 +0200
Message-Id: <20180518081459.553463942@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180518081457.428920292@linuxfoundation.org>
References: <20180518081457.428920292@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1600789161691883041?=
X-GMAIL-MSGID: =?utf-8?q?1600789161691883041?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Xin Long <lucien.xin@gmail.com>

[ Upstream commit 6a9a27d5397fc6c52f90c09ddab91e65053584aa ]

When processing a duplicate cookie-echo chunk, sctp moves the new
temp asoc's stream out/in into the old asoc, and later frees this
new temp asoc.

But now after this move, the new temp asoc's stream->outcnt is not
cleared while stream->out is set to NULL, which would cause a same
crash as the one fixed in Commit 79d0895140e9 ("sctp: fix error
path in sctp_stream_init") when freeing this asoc later.

This fix is to clear this outcnt in sctp_stream_update.

Fixes: f952be79cebd ("sctp: introduce struct sctp_stream_out_ext")
Reported-by: Jianwen Ji <jiji@redhat.com>
Signed-off-by: Xin Long <lucien.xin@gmail.com>
Acked-by: Neil Horman <nhorman@tuxdriver.com>
Acked-by: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/sctp/stream.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/net/sctp/stream.c
+++ b/net/sctp/stream.c
@@ -240,6 +240,8 @@ void sctp_stream_update(struct sctp_stre
 
 	new->out = NULL;
 	new->in  = NULL;
+	new->outcnt = 0;
+	new->incnt  = 0;
 }
 
 static int sctp_send_reconf(struct sctp_association *asoc,

Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x224JHA/iSmf5z7ul6fEA+bkhH9K1gkHQFths+jJNbdtaGe3xk+pz1nOY6EpvSu0dJ0/PNzqi
ARC-Seal: i=1; a=rsa-sha256; t=1517591502; cv=none;
        d=google.com; s=arc-20160816;
        b=Va8E8m3iA965InxNSCPb2mfsDi9iCxBLvqMdBeNXM/ka7qCi8YW+dHsQ84FcTXw4+U
         B6J+tHWCNNWzkkEeppAN4qSkkHV4I09aRkPEP2RBJqV7x/tSvNx2tz0UZaUjnnQ8BhXK
         Nd9k6ZlMcSjmw/EKac1wxWymwKwhPiqT+10e1QvhKZO/B2bnzxmHuP7UyqE/W+M/opHr
         4zjOWjs3JvjmQBAszZVQRGWdeQ8BQGZl45xEGWWlyGZ3fJUPc9u0KFoUnHg79FMURE5s
         8NfuT3xbyFQSeXu5KDcABJn49MozIspodTYaT0Jb96HGHTIG7uopqpPV9WmNmagXj35J
         g+1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=X6J8pnjYGSWYYX6gpDJluTP5MLuwgQcD39EtAyC9rHE=;
        b=R+Nj1hXWYmjx2ac2TJjYH/JC30BUMg36p60xtwHRShTmZxNQGbxnejKsHGZakSoEyr
         oWhIlRmu6vjeAdTai68FBYTZw+TGmCNV2zKfo8LQlq92+Pgd0olxBYFwdOVKlQofMkoL
         7q8hgSyFTG19uPd/uHS0dxpJZOI/GbxNGAY1siCIiDIw1IfaBmbbuwzyBg6iuEssjFRU
         J595qnAzXUDhtkH5bzQeYufCKqEn9PjkzT1QpIjbvz3BlgolsqoN00xA8LNHYVszk67I
         q80zrCUHPxP0akuYvdnIgnpdHCaKzg4vZm4rE5otI8Kbzbb77gcsbdLwWoqSWQdo6V01
         QqAA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Xin Long <lucien.xin@gmail.com>,
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <alexander.levin@verizon.com>
Subject: [PATCH 4.14 072/156] sctp: only allow the asoc reset when the asoc outq is empty
Date: Fri,  2 Feb 2018 17:57:33 +0100
Message-Id: <20180202140843.543142768@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180202140840.242829545@linuxfoundation.org>
References: <20180202140840.242829545@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1591310026836826983?=
X-GMAIL-MSGID: =?utf-8?q?1591310026836826983?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Xin Long <lucien.xin@gmail.com>


[ Upstream commit 5c6144a0eb5366ae07fc5059301b139338f39bbd ]

As it says in rfc6525#section5.1.4, before sending the request,

   C2:  The sender has either no outstanding TSNs or considers all
        outstanding TSNs abandoned.

Prior to this patch, it tried to consider all outstanding TSNs abandoned
by dropping all chunks in all outqs with sctp_outq_free (even including
sacked, retransmit and transmitted queues) when doing this reset, which
is too aggressive.

To make it work gently, this patch will only allow the asoc reset when
the sender has no outstanding TSNs by checking if unsent, transmitted
and retransmit are all empty with sctp_outq_is_empty before sending
and processing the request.

Fixes: 692787cef651 ("sctp: implement receiver-side procedures for the SSN/TSN Reset Request Parameter")
Signed-off-by: Xin Long <lucien.xin@gmail.com>
Acked-by: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@verizon.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/sctp/stream.c |    9 +++++++++
 1 file changed, 9 insertions(+)

--- a/net/sctp/stream.c
+++ b/net/sctp/stream.c
@@ -224,6 +224,9 @@ int sctp_send_reset_assoc(struct sctp_as
 	if (asoc->strreset_outstanding)
 		return -EINPROGRESS;
 
+	if (!sctp_outq_is_empty(&asoc->outqueue))
+		return -EAGAIN;
+
 	chunk = sctp_make_strreset_tsnreq(asoc);
 	if (!chunk)
 		return -ENOMEM;
@@ -544,6 +547,12 @@ struct sctp_chunk *sctp_process_strreset
 		}
 		goto err;
 	}
+
+	if (!sctp_outq_is_empty(&asoc->outqueue)) {
+		result = SCTP_STRRESET_IN_PROGRESS;
+		goto err;
+	}
+
 	asoc->strreset_inseq++;
 
 	if (!(asoc->strreset_enable & SCTP_ENABLE_RESET_ASSOC_REQ))

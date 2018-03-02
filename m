Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELtso8YavEMocWz6SJaBRsXlgzCWAUGui5jXEsaOQ7RkePrQ7HrSQKzPF109/62iBvMlfMmh
ARC-Seal: i=1; a=rsa-sha256; t=1519981526; cv=none;
        d=google.com; s=arc-20160816;
        b=iDeFZECQ4ncwhrqDWv9upQNfNceTrcICtBAvO+E+g8v1i1L559F7mf7nVVqfO6tV+d
         zocnlQpnmek2ZkXRxuh0uYBfsxsDjngNJatvzlzpWLMMltPkB8nN4drKKt6h2GG7FOr+
         6zrKo0AtWEEhynglNkTynqD9+m8j/fe8O8Ye3j+9eYjSxRq1o+Z4utExcfO/WwKSAkxY
         WH3Pn9y9Ibi7fjd8zRy4SnXNnc4pwWKM9xrRvdERDzY17IVhE+AtvO78tIhpYqzFjOVl
         zHbVh6401/irWHfkLdCiU3UjTzpDWG7lI77vTF+g5JoDvg+2wZAXBE9VdW7FT9Y34Xrj
         wHDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=mRD28lse7WbxrLJxDE2qNAwo0nKky5lCFDlFKXJzW/M=;
        b=Mv8Ax8AGv0o8jyKn2WRGCHGkfZw5/ig9TpOdOsWrG7nS3gSR6cb25Z7zc+Lwkz9uvS
         H8CfQqpzCTF9aSGpHZjRa4xYDAl94/hZrFTWyMQEHXD9EW5Gylgk3YmMx/Oh/TELT3zt
         xhs+WC8Oha7o3IA94sG2Ns646hmg502z8MX5NWCaSAWOpl0TDiIVnvPMmubVbeNG6j30
         krSigcK3XnaqRrbNoa2VJBLaItR3rEn5GLJIwaYD4yrbfjn2TCPEpSbHCdZJ/x4he8jW
         SSPjhs/ptoSruH8zOlL/gTGBxw61+wutVEtc0zlIhwqHoPFhxyifyoEVMyOROYFZ8ykU
         c+8w==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Hangbin Liu <haliu@redhat.com>,
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <alexander.levin@verizon.com>
Subject: [PATCH 4.14 102/115] sctp: add a ceiling to optlen in some sockopts
Date: Fri,  2 Mar 2018 09:51:45 +0100
Message-Id: <20180302084507.971363620@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180302084503.856536800@linuxfoundation.org>
References: <20180302084503.856536800@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593816149674955557?=
X-GMAIL-MSGID: =?utf-8?q?1593816149674955557?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>


[ Upstream commit 5960cefab9df76600a1a7d4ff592c59e14616e88 ]

Hangbin Liu reported that some sockopt calls could cause the kernel to log
a warning on memory allocation failure if the user supplied a large optlen
value. That is because some of them called memdup_user() without a ceiling
on optlen, allowing it to try to allocate really large buffers.

This patch adds a ceiling by limiting optlen to the maximum allowed that
would still make sense for these sockopt.

Reported-by: Hangbin Liu <haliu@redhat.com>
Signed-off-by: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@verizon.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/sctp/socket.c |   10 ++++++++++
 1 file changed, 10 insertions(+)

--- a/net/sctp/socket.c
+++ b/net/sctp/socket.c
@@ -3494,6 +3494,8 @@ static int sctp_setsockopt_hmac_ident(st
 
 	if (optlen < sizeof(struct sctp_hmacalgo))
 		return -EINVAL;
+	optlen = min_t(unsigned int, optlen, sizeof(struct sctp_hmacalgo) +
+					     SCTP_AUTH_NUM_HMACS * sizeof(u16));
 
 	hmacs = memdup_user(optval, optlen);
 	if (IS_ERR(hmacs))
@@ -3532,6 +3534,11 @@ static int sctp_setsockopt_auth_key(stru
 
 	if (optlen <= sizeof(struct sctp_authkey))
 		return -EINVAL;
+	/* authkey->sca_keylength is u16, so optlen can't be bigger than
+	 * this.
+	 */
+	optlen = min_t(unsigned int, optlen, USHRT_MAX +
+					     sizeof(struct sctp_authkey));
 
 	authkey = memdup_user(optval, optlen);
 	if (IS_ERR(authkey))
@@ -3889,6 +3896,9 @@ static int sctp_setsockopt_reset_streams
 
 	if (optlen < sizeof(*params))
 		return -EINVAL;
+	/* srs_number_streams is u16, so optlen can't be bigger than this. */
+	optlen = min_t(unsigned int, optlen, USHRT_MAX +
+					     sizeof(__u16) * sizeof(*params));
 
 	params = memdup_user(optval, optlen);
 	if (IS_ERR(params))

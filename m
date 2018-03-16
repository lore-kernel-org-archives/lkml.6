Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELvIPNarc9Asm/9+VCUvQZjqUp8HhgiuOKwg47gzHof53dDnqXoKxZ3IdXb7bZ+6PTA57E90
ARC-Seal: i=1; a=rsa-sha256; t=1521214457; cv=none;
        d=google.com; s=arc-20160816;
        b=TozyQpMz1SOWx7CNA5nXJFUklZMwxjRket1Vo/EyJrIc8e3slYND9KgtloT4IiSmmi
         3mVHvaad7zxvouTaGatDQdTD74xMQs9glQO6kOFAUzlscR/RTzcs2uso19hhkkAxHnzy
         RYg/lHGQqEBdzNqQEnsZMpfcdUmsYSQqW/tj4DFhPsk7SGYImB54EcKtHaL2Eaq1r/+s
         vPETJ+vUitl7YmnuvCCXHEfsJy4f+AUUrpE0AjhJW4vf29uLTCrZ0OVg4DtXjolayu74
         P5sNTxopIXYMLVKksnypQ/hOf9FjgvIHQjRHqdVxDYnoKMP98EoeFc1fK3WEhFdxUQPs
         2w0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=imLj5hd1PC6Uxhsm003G78g9cSjB2yfRrrr1rvsttks=;
        b=qNxKCYT9B7u5K4jMymEV/ZL8/2vrceE+k81xu37s+jMJQLkrGCuDzGmorVvMPyFYcg
         wnepe/tiEsUbtl+UNmoBrYC4ku5/g/vuwADpiXaXhb/Ak49cvg30gyDfHroEMAt2Ay8K
         IXnV5aJyX2Jwvgx/pGD+2Z8xEwJ4N0TJ7BpWY6QU0AfeVGk4Vi8eZKTfLX/WbBThoRCC
         E6R0X4Y3gA638SDBfT4IyqC1QOUd/fV/rllXTtaSgOAL2aUOjDmE1kFdSyXVfbkLT2Hx
         YU6dWYZXWpbXTdAPyWiAsm5gTAjpFBfurgCMCGd3fhflOolYE2kcYQIDBysxEhPOo/KT
         vtQQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Frank Mori Hess <fmh6jj@gmail.com>,
	Ian Abbott <abbotti@mev.co.uk>
Subject: [PATCH 4.14 014/109] staging: comedi: fix comedi_nsamples_left.
Date: Fri, 16 Mar 2018 16:22:43 +0100
Message-Id: <20180316152330.723583665@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180316152329.844663293@linuxfoundation.org>
References: <20180316152329.844663293@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595108638756515720?=
X-GMAIL-MSGID: =?utf-8?q?1595108971151446471?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Frank Mori Hess <fmh6jj@gmail.com>

commit a42ae5905140c324362fe5036ae1dbb16e4d359c upstream.

A rounding error was causing comedi_nsamples_left to
return the wrong value when nsamples was not a multiple
of the scan length.

Cc: <stable@vger.kernel.org> # v4.4+
Signed-off-by: Frank Mori Hess <fmh6jj@gmail.com>
Reviewed-by: Ian Abbott <abbotti@mev.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/staging/comedi/drivers.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

--- a/drivers/staging/comedi/drivers.c
+++ b/drivers/staging/comedi/drivers.c
@@ -484,8 +484,7 @@ unsigned int comedi_nsamples_left(struct
 	struct comedi_cmd *cmd = &async->cmd;
 
 	if (cmd->stop_src == TRIG_COUNT) {
-		unsigned int nscans = nsamples / cmd->scan_end_arg;
-		unsigned int scans_left = __comedi_nscans_left(s, nscans);
+		unsigned int scans_left = __comedi_nscans_left(s, cmd->stop_arg);
 		unsigned int scan_pos =
 		    comedi_bytes_to_samples(s, async->scan_progress);
 		unsigned long long samples_left = 0;

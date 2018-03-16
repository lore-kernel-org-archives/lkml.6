Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELtJQ9CF9zsRVez2VQ5wSkxInyxqC9iUJEgQi8PhBcub34ACmO5w0NyHY99t+yKSFene+bxq
ARC-Seal: i=1; a=rsa-sha256; t=1521214140; cv=none;
        d=google.com; s=arc-20160816;
        b=Gk9bCveQXvL44S3+r+LuN6xk/hYsjriUwwhyP9APKrKYB3VSu3kCIesOg4OG7jmLgi
         MtQSzV+BMBtX0fm/lPI3/pnfbNDwj3qq0jU199Zvui7QXCQzhMwj9t8EDtGNyVg7fLu7
         bR2VtJtGoa818OYnwt9RSQ/C7WhOU74j0fgXaEBhtiVNWyAWJGz6oG8bMLA2M+mExEM0
         Ns+RTqZGmlumb7pc2nvrxYparHg5naJSu4Vpnu7NIvQkyDhLXIeZFPFavPkf8wBVrjBy
         p3CP9RVQ17Q3ojdxVaK+HS4qy4UmrZNVpF1e3WgbsXmV8bFPxMzmEYcHYphjy5DRY4OR
         0f7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=Lf4zu0l7yxgQWGPAI+P8c3D+ekGl09YxXJUYKSlDNH4=;
        b=PPCccfDqKpccCao9GUpkeZhL2nDW2+DR/XdZb2yTQu95QL7ep51PZebYexrecS67/V
         l4cj34uuWC+O95iICK5+Sm/uo5eY6mqRYwbp9vM/6by2KHL7CrCaIfGnlFLgcUCQBmls
         EMq8an/2RvXwL8fSRUIFjB5ROnjoOVr8mmlvApHhYgY44zEo2hM/55DNhLIfYV34DrWH
         MhFnYWiZqr2bRwCXLLNXJC13p3C0a5plOExi7sRYvm09E6yzSaIqrzW5RcFb1cyVNmsu
         VLN+IU5bHY6hjChpy9DehBCMszYGl+XVGP009Af9AI5alitbEva4YGpqUUR88aQ6RTnx
         2hcg==
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
Subject: [PATCH 4.4 55/63] staging: comedi: fix comedi_nsamples_left.
Date: Fri, 16 Mar 2018 16:23:27 +0100
Message-Id: <20180316152305.984404523@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180316152259.964532775@linuxfoundation.org>
References: <20180316152259.964532775@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595108638756515720?=
X-GMAIL-MSGID: =?utf-8?q?1595108638756515720?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

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

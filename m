Return-Path: <SRS0=We5Z=IL=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZpQDxSgCmxTfhYgEUiSQwpmVLSa0wW0mynA+xeTcQfmTujwOma6Z16iWL0Lc0Y2mbvIF5jO
ARC-Seal: i=1; a=rsa-sha256; t=1527155680; cv=none;
        d=google.com; s=arc-20160816;
        b=BaboQMV9oy9gQI06/aI6k9R2KgCQUjNks9FonkiiokYIvwgP4Tbgesyf7QE0OUzRGn
         TaO8ww8hVBeWVjbjMY8BhEVgg5nesiS/FBBJdlNK8RdxP8SkSturI2dxNYw+v7wG4wXl
         LVE2D2U4Uv9kzWgfTTRNg1LrlyCPasiHeBSm/vJjeVn1kcF1PJgBIFyzitm9jHRmPIS9
         gANaeRLJG91l2QDj08LYSo7/SQRYnKCCkwJyCQ3BnD5GaP1WOFWthjkP4vevSvQOf1Km
         Ja6oP7MJUe4sPhrL5blmM+vaRDhrwtUJa14J5ZBixY8nvPQl0K3EY+6B/wLGhg6hBFJt
         ip4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=+uol2akEooR1lrN+vm1jRTwjCy4jZBY7j0sluJCfDGs=;
        b=lpQts+e8uXrzQUogTzRBA8qoDNz3sflii5ACHNf6G7ulRTUyp/6LKNr/cIBzIszDJE
         eNf1SiqqdDZ1b2fIZUg11dbQXZUU3gu41D2ogNMrVQEJEyltXDZccAalEFFyhw/FJ+W3
         yOBaV5wfmCmZcoqXBdUwcLv6quhNjplmRYZ6zKwaUgLlFY8kYUF76GrTI9NkSnZm9XOi
         G9hnzHobz3ZlQryEXb+kurUjAIK0pVzp8xCgVXmFP8gPM/2jeJ+q3m7FITfw6pZXNYZQ
         fps6OrktesoTa6WoNYX2bUrBgWJjkyM1Irak4EkU5AZ7D1294BZ4CtcR+OsZbMPqtXh7
         G7Rw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=XxlCxafw;
       spf=pass (google.com: domain of srs0=we5z=il=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=We5Z=IL=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=XxlCxafw;
       spf=pass (google.com: domain of srs0=we5z=il=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=We5Z=IL=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Lars-Peter Clausen <lars@metafoo.de>,
	Felipe Balbi <felipe.balbi@linux.intel.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 076/165] usb: gadget: ffs: Let setup() return USB_GADGET_DELAYED_STATUS
Date: Thu, 24 May 2018 11:38:02 +0200
Message-Id: <20180524093625.099127926@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180524093621.979359379@linuxfoundation.org>
References: <20180524093621.979359379@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1601338408734906633?=
X-GMAIL-MSGID: =?utf-8?q?1601338795104427688?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Lars-Peter Clausen <lars@metafoo.de>

[ Upstream commit 946ef68ad4e45aa048a5fb41ce8823ed29da866a ]

Some UDC drivers (like the DWC3) expect that the response to a setup()
request is queued from within the setup function itself so that it is
available as soon as setup() has completed.

Upon receiving a setup request the function fs driver creates an event that
is made available to userspace. And only once userspace has acknowledged
that event the response to the setup request is queued.

So it violates the requirement of those UDC drivers and random failures can
be observed. This is basically a race condition and if userspace is able to
read the event and queue the response fast enough all is good. But if it is
not, for example because other processes are currently scheduled to run,
the USB host that sent the setup request will observe an error.

To avoid this the gadget framework provides the USB_GADGET_DELAYED_STATUS
return code. If a setup() callback returns this value the UDC driver is
aware that response is not yet available and can uses the appropriate
methods to handle this case.

Since in the case of function fs the response will never be available when
the setup() function returns make sure that this status code is used.

This fixed random occasional failures that were previously observed on a
DWC3 based system under high system load.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Signed-off-by: Felipe Balbi <felipe.balbi@linux.intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/gadget/function/f_fs.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/usb/gadget/function/f_fs.c
+++ b/drivers/usb/gadget/function/f_fs.c
@@ -3239,7 +3239,7 @@ static int ffs_func_setup(struct usb_fun
 	__ffs_event_add(ffs, FUNCTIONFS_SETUP);
 	spin_unlock_irqrestore(&ffs->ev.waitq.lock, flags);
 
-	return 0;
+	return USB_GADGET_DELAYED_STATUS;
 }
 
 static bool ffs_func_req_match(struct usb_function *f,

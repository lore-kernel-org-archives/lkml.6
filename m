Return-Path: <SRS0=We5Z=IL=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZrGHo16+a2yzOL0AZJm4Jv1lidKD9QYAlbkF0X1aFw6oKL4UBmdcnn/IyLMGAbmiMTrSvoA
ARC-Seal: i=1; a=rsa-sha256; t=1527156354; cv=none;
        d=google.com; s=arc-20160816;
        b=jFiTvGa7UrsqSG0T3VhSmmJq7ZNkT2Lr9h66JDN4sb5nvvd2ZwbfT6S6al4anla2HC
         Dw9N94aBx6kLN4dkgH/7upTWpEzYqwvKzAp/e7lNDW5Hisxiz344dkotbWHctTGXZ457
         dCzHtEA4YUcOhbtD6bkZNJ9yaybAVqZdqQyya/dbNr5YX/lJyq7HPDB2nSx1UuglhVPa
         8J1cWwGKNfsts7iFbdA5V7pYou5B4bOIADqRSugJ2yapTV+tvVDwfOHUFLNw/82U92/9
         oKJVKvJ/TuziYfRqW9d0gjl3aOBUS7qEkypgLAqU53PEJ9HiPFE31B45gPB7vjtRPjFQ
         lO4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=CE+kouUcWUsalEOckoJXoYJ90qIzFe8SnWRxJBfIgAA=;
        b=AWqI+9y6bMs/0HAUk3Vx4eIdxmaw0xqzXUwvqGFT0F1DZibU+52tn2KuT8tOYsdT+a
         uphX33kEJxEIi5x8jh+fTnJOQs0MU6oDCBxt5NEnagEogOtqdWYALqPyud3penMBZq6b
         jdO1Ai6aX0k+pSdd6DyLsfFN/ZnujKODo0icDeqxDOAwKZRVPise2WwtIR/5TGABDfi3
         ROjlEhaWOXDaAQixkOnKVTl1iEwtIYla15Tt157RJEyoRj7tS4157Fl97sfDjbEYDmVq
         9SX47CQPU7s1hL5psmUT8tbS0m9ZahfBhRJYKRqrx/NFg5os0GYSlkXR3ToGI16wekXB
         VClw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=Wurec2he;
       spf=pass (google.com: domain of srs0=we5z=il=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=We5Z=IL=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=Wurec2he;
       spf=pass (google.com: domain of srs0=we5z=il=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=We5Z=IL=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.16 156/161] rtc: hctosys: Ensure system time doesnt overflow time_t
Date: Thu, 24 May 2018 11:39:41 +0200
Message-Id: <20180524093036.909880365@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180524093018.331893860@linuxfoundation.org>
References: <20180524093018.331893860@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1601338572452094265?=
X-GMAIL-MSGID: =?utf-8?q?1601339501210790813?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alexandre Belloni <alexandre.belloni@bootlin.com>

[ Upstream commit b3a5ac42ab18b7d1a8f2f072ca0ee76a3b754a43 ]

On 32bit platforms, time_t is still a signed 32bit long. If it is
overflowed, userspace and the kernel cant agree on the current system time.
This causes multiple issues, in particular with systemd:
https://github.com/systemd/systemd/issues/1143

A good workaround is to simply avoid using hctosys which is something I
greatly encourage as the time is better set by userspace.

However, many distribution enable it and use systemd which is rendering the
system unusable in case the RTC holds a date after 2038 (and more so after
2106). Many drivers have workaround for this case and they should be
eliminated so there is only one place left to fix when userspace is able to
cope with dates after the 31bit overflow.

Acked-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/rtc/hctosys.c |    5 +++++
 1 file changed, 5 insertions(+)

--- a/drivers/rtc/hctosys.c
+++ b/drivers/rtc/hctosys.c
@@ -49,6 +49,11 @@ static int __init rtc_hctosys(void)
 
 	tv64.tv_sec = rtc_tm_to_time64(&tm);
 
+#if BITS_PER_LONG == 32
+	if (tv64.tv_sec > INT_MAX)
+		goto err_read;
+#endif
+
 	err = do_settimeofday64(&tv64);
 
 	dev_info(rtc->dev.parent,

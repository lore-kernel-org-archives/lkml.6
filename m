Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48K6szrpQQf65/YilFv0Hrk6VTlBSyihID7NFzA0X2FIk/G4BpWhmcDjA+iOh09trQgex3a
ARC-Seal: i=1; a=rsa-sha256; t=1523399204; cv=none;
        d=google.com; s=arc-20160816;
        b=vXNulll4uCgTq1C5itzEeD6EGgIkTaVKE92sOW2hW/OHnTuKyT13SeBD7NuH9fppJC
         qMqL6HQH/G8nPx1QN6vQbUVxky5rp12Et1+NABJVHXJqrkgfQ+n6m/IjAajpHoAMPP6/
         WnFbVD71wgO7SEnej/GrbQESpNzXCT5Rm3joXuIsIVe+Y2yUEemhLfX+mtiRluiawFxr
         dPldGMTmdQO6PXM4Z90gDYBfQd6UwtAFdXLZkY1fV+7YZSNh+il1ubP91IYZ1eU1Z39i
         2hHW4lPXsU8Pv+6SWoCaA25u0SMW2BMI4gnZC1OleAS+1yVlivb4rxe4QcIQ3KJQZZOy
         3FTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=UlSHB6yB0kkP4Wvn8ABuuutqDRYt5oDSs27tq72Iexw=;
        b=zefI7IuYheLJjAdRS0DPjEqmP2GHTN2K/SJ/yL297IY3AH6YhyaEiCWIs1WOa31waP
         lKNWUCNHDF5SLSbC2uKiEvRjXvYdD//6bwYYiHCmnPc2Gn4WWNsBHdgZVnR8/lL4ckN9
         WA+VjLzLnCqqC09KF0suU/47OlCXZYojGmESwwsHgZnMlupIlgP/MJRwzS2iIpC1XTe4
         hl+wcJBXhqsj3voZ8aDfXb6s6MMaUJlss/fGYyI0Js/SD/klSsHZXPLEaeA3ZN2dN7sM
         Ns83XCOu1ZRVMjsDPNXiXrzU7fS0OwAYql9lIdyE3O1pu7poLpt3ZahwJ8KPWb7L8gY2
         +Gaw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	"Gustavo A. R. Silva" <garsilva@embeddedor.com>,
	Chanwoo Choi <cw00.choi@samsung.com>,
	MyungJoo Ham <myungjoo.ham@samsung.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.15 024/168] PM / devfreq: Fix potential NULL pointer dereference in governor_store
Date: Wed, 11 Apr 2018 00:22:46 +0200
Message-Id: <20180410212801.228017307@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180410212800.144079021@linuxfoundation.org>
References: <20180410212800.144079021@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597399843849765042?=
X-GMAIL-MSGID: =?utf-8?q?1597399843849765042?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: "Gustavo A. R. Silva" <garsilva@embeddedor.com>


[ Upstream commit 63f1e05f7fe9ca509c60154d6a833abf96eecdc9 ]

df->governor is being dereferenced before it is null checked,
hence there is a potential null pointer dereference.

Notice that df->governor is being null checked at line 1004:
if (df->governor) {, which implies it might be null.

Fix this by null checking df->governor before dereferencing it.

Addresses-Coverity-ID: 1401988 ("Dereference before null check")
Fixes: bcf23c79c4e4 ("PM / devfreq: Fix available_governor sysfs")
Signed-off-by: Gustavo A. R. Silva <garsilva@embeddedor.com>
Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>
Signed-off-by: MyungJoo Ham <myungjoo.ham@samsung.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/devfreq/devfreq.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -996,7 +996,8 @@ static ssize_t governor_store(struct dev
 	if (df->governor == governor) {
 		ret = 0;
 		goto out;
-	} else if (df->governor->immutable || governor->immutable) {
+	} else if ((df->governor && df->governor->immutable) ||
+					governor->immutable) {
 		ret = -EINVAL;
 		goto out;
 	}

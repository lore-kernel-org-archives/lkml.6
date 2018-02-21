Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x226yekMLDCJXoTeIX5R8s9Qz5RjSrZOvjbMlG7fl+tupmULuNh41pMr4PeYZO4So52JE6d8W
ARC-Seal: i=1; a=rsa-sha256; t=1519218613; cv=none;
        d=google.com; s=arc-20160816;
        b=NyKY3Ygw8zckLD3GWf8msAWflOMfPOT6WXfhqnHgrkEWJd5uMBJUDbGjPID0onjb4H
         6fk7QcO7PyXWqPm7vr+TzT8F182MWVqsZ3i7g519gMkYSLoNG/aH/wtvrtshGNhrlTQf
         1HyV+1M9ZbEi36bg3VhvpY38r8Av2bylMtUYRKUfvY0EjBC4SIMsAilORH5Xce12ripE
         JKS8cfXfc5vu07abS9/S3u3ED8o5CNEenu55O7+jNhy1mzIbXWp0c5qy/nBFJ4b5fEGJ
         K6GSA35LlRjbZA2weyp7xCHieKe1iYyawqHd+UtYkT04LcuDgKDu2/e56kJfUkBvzhhD
         Yndw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=SU/2h955TC+7S1FOZbyN0vK1DF160usbuqhFkBKa2Ec=;
        b=wtzk1aaPmYaQfQQg/2zAdDI7WkHwSVWFXUJ/LniAxhYd0KDAew1OlfVtRiLH/JFL6o
         2uCWli+0UA5dP/o1q4r/25B0prl4oNnXDiy+m/iUxzCchW6JgGWvgJLK8UWA1jJpXTk2
         OAGzKY3V7MyPXPwxsSd68V9EHvmZxqR43CDYZN/dIHDkEL7knYD6nd2SP0witWtcW6Sy
         b+D0T1W+owWd2xIBJBo9ElFjfphwzGZd5HHPj1k0o1IC5yoI8gTz6mEC8FzSdTYUszID
         gCubGcNCB2Xn4UPxXxBBde/hKiOF1SiK4bP1NBrh1e76vUKs9t0he91JMLBViizlaDdm
         FQVg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Lukas Wunner <lukas@wunner.de>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH 4.15 055/163] PM / runtime: Update links_count also if !CONFIG_SRCU
Date: Wed, 21 Feb 2018 13:48:04 +0100
Message-Id: <20180221124533.499794527@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180221124529.931834518@linuxfoundation.org>
References: <20180221124529.931834518@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593015541815061053?=
X-GMAIL-MSGID: =?utf-8?q?1593016177534298997?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Lukas Wunner <lukas@wunner.de>

commit 433986c2c265d106d6a8e88006e0131fefc92b7b upstream.

Commit baa8809f6097 (PM / runtime: Optimize the use of device links)
added an invocation of pm_runtime_drop_link() to __device_link_del().
However there are two variants of that function, one for CONFIG_SRCU and
another for !CONFIG_SRCU, and the commit only modified the former.

Fixes: baa8809f6097 (PM / runtime: Optimize the use of device links)
Cc: v4.10+ <stable@vger.kernel.org> # v4.10+
Signed-off-by: Lukas Wunner <lukas@wunner.de>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/base/core.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -313,6 +313,9 @@ static void __device_link_del(struct dev
 	dev_info(link->consumer, "Dropping the link to %s\n",
 		 dev_name(link->supplier));
 
+	if (link->flags & DL_FLAG_PM_RUNTIME)
+		pm_runtime_drop_link(link->consumer);
+
 	list_del(&link->s_node);
 	list_del(&link->c_node);
 	device_link_free(link);

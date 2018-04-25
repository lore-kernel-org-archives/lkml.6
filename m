Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/btSDh99UFv0ndP0tj+JxVSDDrdHbG+695/K/2tIOSra2xqsqf419ttvquVC0LwIPXHjtz
ARC-Seal: i=1; a=rsa-sha256; t=1524653035; cv=none;
        d=google.com; s=arc-20160816;
        b=1GpXLtyN06wg/x83uZuBaXwcrXNjQZUwk3Xug5AzeGxJR4CGzMkGggGehLfE4cKDqn
         HY3+jC4eZwToYqs8hb9CeWNEU0P2FFIXyIdmAmv4TpWbLk40itHG4Lc/Kggb0Y6AxjVr
         oM0tBKLxRLSj4aLNPcaDu7MZxDwuJEGrAD9mTAwv/pDi5f9JkzqxgyYWbWOIdN1lt3Y2
         WolBlsjU4lN7mHyfxtnN8nEVO4QO4Hg7dRyPQbl2ApuP05A3HIGbVu7+9qBAxQnuBNxo
         p6uNbwRPc16qdUlgNc8BJnMEszM37yZElrPuaUVezSA8GTcPRvX1uy+mf6/5M6+npCYK
         cV8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=7cRwGtzfBvdl0WGQ4EVcjKMw8zg+p3YvsZRq4Wbt+W0=;
        b=HihbbklJLHDczKvh/9DknYHvIegleDBcesc2CgHnw0h5nPIhF3JQQzQJ2GZRVtCVNN
         ThyQqpfptGbYtuu4LFtkMckxh+Wff2EQsi78hQ1uPrtAIdwk3xeduDR8aQyJ7VjE9bdp
         r8a3eOQulHo1vlI6M1mwo56zXyP15gQaJBWpOndKi0iJVW+y/sG8Bhka3quA5H8EfjHR
         TupQZyMXE2OGfy+gmHj49pUPgs2hP6wIoOQcUHUKvoHX4bIrReBFJISxX44ti5515tKk
         ymlyYJtK1FSYBHIls8kfL/acSdw9780wkcZ00bkOHaTCtDZGCe/Vy6MR/QstGeP8bRFP
         UVzw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Markus Demleitner <m@tfiu.de>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 161/183] ACPI / EC: Restore polling during noirq suspend/resume phases
Date: Wed, 25 Apr 2018 12:36:21 +0200
Message-Id: <20180425103248.999623634@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180425103242.532713678@linuxfoundation.org>
References: <20180425103242.532713678@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598714581889896941?=
X-GMAIL-MSGID: =?utf-8?q?1598714581889896941?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>


[ Upstream commit 3cd091a773936c54344a519f7ee1379ccb620bee ]

Commit 662591461c4b (ACPI / EC: Drop EC noirq hooks to fix a
regression) modified the ACPI EC driver so that it doesn't switch
over to busy polling mode during noirq stages of system suspend and
resume in an attempt to fix an issue resulting from that behavior.

However, that modification introduced a system resume regression on
Thinkpad X240, so make the EC driver switch over to the polling mode
during noirq stages of system suspend and resume again, which
effectively reverts the problematic commit.

Fixes: 662591461c4b (ACPI / EC: Drop EC noirq hooks to fix a regression)
Link: https://bugzilla.kernel.org/show_bug.cgi?id=197863
Reported-by: Markus Demleitner <m@tfiu.de>
Tested-by: Markus Demleitner <m@tfiu.de>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/acpi/ec.c |    6 ++++++
 1 file changed, 6 insertions(+)

--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -1927,6 +1927,9 @@ static int acpi_ec_suspend_noirq(struct
 	    ec->reference_count >= 1)
 		acpi_set_gpe(NULL, ec->gpe, ACPI_GPE_DISABLE);
 
+	if (acpi_sleep_no_ec_events())
+		acpi_ec_enter_noirq(ec);
+
 	return 0;
 }
 
@@ -1934,6 +1937,9 @@ static int acpi_ec_resume_noirq(struct d
 {
 	struct acpi_ec *ec = acpi_driver_data(to_acpi_device(dev));
 
+	if (acpi_sleep_no_ec_events())
+		acpi_ec_leave_noirq(ec);
+
 	if (ec_no_wakeup && test_bit(EC_FLAGS_STARTED, &ec->flags) &&
 	    ec->reference_count >= 1)
 		acpi_set_gpe(NULL, ec->gpe, ACPI_GPE_ENABLE);

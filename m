Return-Path: <drake@endlessm.com>
ARC-Seal: i=1; a=rsa-sha256; t=1521188606; cv=none;
        d=google.com; s=arc-20160816;
        b=zWsH3SU2ozHzKFkzJw1TJApCd2MzJTXGuqNJgzGNq7jpxnqL78Om9oQOdPZ7uflgBg
         itZ3BMUCHkTn5mYBYXysVjQmsQz+V9zxltXumVGq7uMpeaSe5YWsU5SuZSVxJnyRHsqG
         hcN4Jje2myspn1Ri0MwvPnrVqpvIGK8GfG7qlcpcM7rtI6/ANsD6H0jRPXvdbdvMleR2
         jVXqj2w1TQ14gNsouSBGjr3TFq41yvoO9JMaoU/Jb3AJbSS43azb4sD/nbK8Jau/x1Gn
         DtBZ11ah0DgQZCi5P5ye+fERByXuOGcddipnJ7lmAPdaSzXMpCivL3CXHAYhiU2kMcNw
         M6Zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=4i5siEwaUSGR3LyEy0tCpOsUzypoVAOFbD6wLBjr4M8=;
        b=LlMaBEVYFRtrC68TgBYupdga6KN0fVL9f0fN4FJN0zAVyjLuGj6C7hTsoc523Z+V+C
         nxQShiOQsu+41h6Lx/N/nK0PQIPYJSaXb9bCN9fziUV8G46cUxThb+wf1T+XTXRTQT/b
         +WMNXo3rNL5Lsk8lo/tQ3oGcIn+hvi4RUkv4m68GeSEp6TZDH9mfXgKkFp8SthBHH7AW
         7ZvhJKkrnfbPiCTSNHgMY1aPknU+kOOj6rvt6FnnvbQJVKD1Ff//5bfSTAcvqBzOVj/h
         Cjxtcj5yMTkvdmAR1B8OL+Uu8Lbc17hwzuVhc2ZpnrjGyrAoIvllXKjTojEwZW5BhqVm
         I7YA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@endlessm-com.20150623.gappssmtp.com header.s=20150623 header.b=N47b7qDm;
       spf=pass (google.com: domain of drake@endlessm.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=drake@endlessm.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@endlessm-com.20150623.gappssmtp.com header.s=20150623 header.b=N47b7qDm;
       spf=pass (google.com: domain of drake@endlessm.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=drake@endlessm.com
X-Google-Smtp-Source: AG47ELu1WdNMC8vLnIob9ZmqsrTFsFrs5vABfsBFQUsM23NQcfd7sHBfuA92schFlbxwPvkQaXvHgQ==
From: Daniel Drake <drake@endlessm.com>
To: mathias.nyman@linux.intel.com
Cc: chiu@endlessm.com,
	mathias.nyman@intel.com,
	gregkh@linuxfoundation.org,
	linux-usb@vger.kernel.org,
	linux@endlessm.com,
	linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org
Subject: Re: Intel GemniLake xHCI connected devices can never wake up the system from suspend
Date: Fri, 16 Mar 2018 16:23:20 +0800
Message-Id: <20180316082320.12636-1-drake@endlessm.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <CAD8Lp45tvQP0aA=6zg+1j-_0jTxyyNxnrL=Gt0+0WrzeT6XS0Q@mail.gmail.com>
References: <CAD8Lp45tvQP0aA=6zg+1j-_0jTxyyNxnrL=Gt0+0WrzeT6XS0Q@mail.gmail.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594977262317953417?=
X-GMAIL-MSGID: =?utf-8?q?1595081864381118094?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

> I've studied the ACPI spec trying to understand better, but I'm
> struggling with the question:
> What is the maximum number (lowest power) permitted device power state
> for a device that is configured as able to wake the system from S3,
> **that does not implement the _S3W method**?

Actually the ACPI spec has an answer for the case when _S3D is present.
The lack of clarity is only over the situation when both _S3D and _S3W
are missing - like on the platforms being worked on here.

The _S3D docs say:
> If the device can wake the system from the S3 system sleeping state (see
> _PRW) then the device must support wake in the D-state returned by this
> object. However, OSPM cannot assume wake from the S3 system sleeping state
> is supported in any deeper D-state unless specified by a corresponding
> _S3W object

Looking at the design of the existing Linux code, it seems like this
"max = min" assignment that is causing us trouble originates directly
from an attempt to implement that logic: if we didn't get a response from
_S3W, then we must clamp ourselves to the data we got from _S3D.

If I modify the Linux code to be a little more specific in that logic
(only applying when we actually got something from _S3D) then the
problematic behaviour is avoided and USB wakeups work.

I feel that this change makes the Linux implementation more directly
mirror the wording in the ACPI spec and it's associated lack of clarity
for when both methods are missing. Thoughts?

---
 drivers/acpi/device_pm.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/device_pm.c b/drivers/acpi/device_pm.c
index a4c8ad98560d..44f12c5c75ee 100644
--- a/drivers/acpi/device_pm.c
+++ b/drivers/acpi/device_pm.c
@@ -543,6 +543,7 @@ static int acpi_dev_pm_get_state(struct device *dev, struct acpi_device *adev,
 	unsigned long long ret;
 	int d_min, d_max;
 	bool wakeup = false;
+	acpi_status sxd_status;
 	acpi_status status;
 
 	/*
@@ -565,8 +566,8 @@ static int acpi_dev_pm_get_state(struct device *dev, struct acpi_device *adev,
 		 * provided if AE_NOT_FOUND is returned.
 		 */
 		ret = d_min;
-		status = acpi_evaluate_integer(handle, method, NULL, &ret);
-		if ((ACPI_FAILURE(status) && status != AE_NOT_FOUND)
+		sxd_status = acpi_evaluate_integer(handle, method, NULL, &ret);
+		if ((ACPI_FAILURE(sxd_status) && sxd_status != AE_NOT_FOUND)
 		    || ret > ACPI_STATE_D3_COLD)
 			return -ENODATA;
 
@@ -599,7 +600,11 @@ static int acpi_dev_pm_get_state(struct device *dev, struct acpi_device *adev,
 		method[3] = 'W';
 		status = acpi_evaluate_integer(handle, method, NULL, &ret);
 		if (status == AE_NOT_FOUND) {
-			if (target_state > ACPI_STATE_S0)
+			/* No _SxW. In this case, the ACPI spec says that we
+			 * must not go into any power state deeper than the
+			 * value returned from _SxD.
+			 */
+			if (sxd_status == AE_OK && target_state > ACPI_STATE_S0)
 				d_max = d_min;
 		} else if (ACPI_SUCCESS(status) && ret <= ACPI_STATE_D3_COLD) {
 			/* Fall back to D3cold if ret is not a valid state. */
-- 
2.14.1

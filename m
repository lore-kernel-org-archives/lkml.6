Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELvv+b+Adaw8D5BJhMNSZT3vNnp7pTywILV1bxJwg95W0yIt4WBoEy2XbPwdFz2YheZ0vyx0
ARC-Seal: i=1; a=rsa-sha256; t=1519981004; cv=none;
        d=google.com; s=arc-20160816;
        b=PqhJE1GzkHugFZrAcx4rTrWASO9XzXp3/CIlaikKXvKwMr5rz08RxGKdyfWArqIuHs
         tLcjjW8MNjysWo57LaRHqW4JNRdzSuP5ra8kRXqkPm4RVDHGw4u1p6SigcNzxW9VuNC0
         cc6BXEspHj0Igkp/ZjqffixN7kwJl423hyjMd3C4hW2/P0XRd4gzz1Cwkj+PxUzauXC8
         X+E+KNS+Wc3r1f/LrWKRJwCqxVDnT2ZrbggRWVRqfM0Cshz+qVAckJZcZd8LZJDkYZJh
         PD8yTnUvWXfXE/+jGB4YUQOTnCI4dcOjh41xyaF/yc2jFXWtMMmXnMDk18JNzEenzhxU
         Ul7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=Jz6ItHKkYgiJ36b3SWJr95wXZE0AcTDBWvvIeYqdCik=;
        b=HN+QnQ+Fq4AGuEdWtHgW2jdkh6K/PQBURTJhfKUKPLM50gb5bCXkaGCY9zWlz+N57K
         xIsOFYGXaDupG8KLgbWqgCRCNBEtbVHrR+d6QPdP1+B8nVVp+i+oAHnGUHGwX50jmWgW
         OI+qhgxFhqtk4nx55XCoH9EOe4S0YfUYnDLmiIpz2c0Er3WZw0ywVSFEZEiXEcG13kOM
         xSiLC5USy8DevL9HV+IsWfpL6EYjBMcmsVT3I3BVZub24QHXedJBTQ5ghKgip/xOj3cb
         bs6mJSKJVjkMeCkJgLOekf50BUUeKku52UqW29L7AzBJBCs+PIf99Sw8Hsr3JaQs8Rj+
         G8IA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Cathy Avery <cavery@redhat.com>,
	Long Li <longli@microsoft.com>,
	Stephen Hemminger <stephen@networkplumber.org>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 22/56] scsi: storvsc: Fix scsi_cmd error assignments in storvsc_handle_error
Date: Fri,  2 Mar 2018 09:51:08 +0100
Message-Id: <20180302084450.724469242@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180302084449.568562222@linuxfoundation.org>
References: <20180302084449.568562222@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593815429264210567?=
X-GMAIL-MSGID: =?utf-8?q?1593815602533964037?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Cathy Avery <cavery@redhat.com>


[ Upstream commit d1b8b2391c24751e44f618fcf86fb55d9a9247fd ]

When an I/O is returned with an srb_status of SRB_STATUS_INVALID_LUN
which has zero good_bytes it must be assigned an error. Otherwise the
I/O will be continuously requeued and will cause a deadlock in the case
where disks are being hot added and removed. sd_probe_async will wait
forever for its I/O to complete while holding scsi_sd_probe_domain.

Also returning the default error of DID_TARGET_FAILURE causes multipath
to not retry the I/O resulting in applications receiving I/O errors
before a failover can occur.

Signed-off-by: Cathy Avery <cavery@redhat.com>
Signed-off-by: Long Li <longli@microsoft.com>
Reviewed-by: Stephen Hemminger <stephen@networkplumber.org>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/scsi/storvsc_drv.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/scsi/storvsc_drv.c
+++ b/drivers/scsi/storvsc_drv.c
@@ -915,10 +915,11 @@ static void storvsc_handle_error(struct
 		case TEST_UNIT_READY:
 			break;
 		default:
-			set_host_byte(scmnd, DID_TARGET_FAILURE);
+			set_host_byte(scmnd, DID_ERROR);
 		}
 		break;
 	case SRB_STATUS_INVALID_LUN:
+		set_host_byte(scmnd, DID_NO_CONNECT);
 		do_work = true;
 		process_err_fn = storvsc_remove_lun;
 		break;

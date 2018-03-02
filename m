Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELtuEVES1NcAQjNzuplpD9t9hkJvY8GcKYNnDtY3owTGjTG/9QVD3PeYJ2g9ZKMkpPXq3zFZ
ARC-Seal: i=1; a=rsa-sha256; t=1519980839; cv=none;
        d=google.com; s=arc-20160816;
        b=Yuv+D+qE8xZOTbt17NuQWvIFR23R+/nhKu2sVfyY8KlchogDS/I8PpuZ1M7CYJKcma
         rCAgF4Jx0+FIEj8OnKgazQzUyRVSaSb6OpGT9dNTIRyNbFkj0e2eMoTbtPfbi+Ovy+Mt
         o1bdGZc/tA6u1ZoWV3pJNXF+LWFzOVt8nLjKlYY5hlWEEDvbgAA5krVWECEc2E6uiQlL
         UWqAc6lRbxZgVPk7JhNks00cgf9ppJarYD/kMuzUV5igk5Wr/OgWOvMLuYgKMGBnBfQI
         wGTslq4qALXCSFmOX0kKTfl24Reu0pOfbaw1K7cUpvqfu6ySKKHyxWO4J+GkiQAutb6d
         5UtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=1yL8OfDW7CsSceOXZPrMSQD7QPmbL6eNrUBe1jdPDNs=;
        b=R1MAOD4AQvr/vC1cXhcjObva6HfRYseDUWcgGlzO1EpRQfZbDTglMsX0BJ83itFDmr
         e8jZ25nEFMbGQEW6JLQCeWiW08LWL97MaxhPUp6QPO3bNQc1KXb/rmaxOYWT3QZj/bFw
         yFgJ0EGbaQI8Wud/a3otKVEeG4JeQ9nVf4U6kSFycPjziVYXaSuHu+SwrYCZRwSH2Txg
         COzyTQmUwLdCV2YOoMAWHwGHIcFpFYjXu/hKnOdhEvfXaFCN+BmOa5Z+dbEnEiPr5EZe
         Ukg5rAfeQfBD6sRaRBuRqA/virWji+9kZcEfRjCOI7LxLPR4leGzqox2N1a5bn96STHI
         nJNQ==
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
Subject: [PATCH 3.18 08/24] scsi: storvsc: Fix scsi_cmd error assignments in storvsc_handle_error
Date: Fri,  2 Mar 2018 09:51:05 +0100
Message-Id: <20180302084239.577866933@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180302084239.157503766@linuxfoundation.org>
References: <20180302084239.157503766@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593815429264210567?=
X-GMAIL-MSGID: =?utf-8?q?1593815429264210567?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

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
@@ -1029,10 +1029,11 @@ static void storvsc_handle_error(struct
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

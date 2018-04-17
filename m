Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48bMJQsvX4g0qbnhjVxxPXuW53XVoadRsNVXO9jxp6LjqlpxF67jIlgxR55pc64yXH2fqm7
ARC-Seal: i=1; a=rsa-sha256; t=1523980919; cv=none;
        d=google.com; s=arc-20160816;
        b=mhtCVCY3T1qBZowjY+K19fDQYcqyVjKgmuCFSYXRc+pSmnCgMH8leUyVaUmD+Wj2bT
         SjV1PCr6yw8KVsZfiXmpHY6Oi/tVjcTRmMAqH1ppxK5cN8eUZEXTsjUoqrdnYBlwxoyi
         6jjOF8SVWGiM1x38A5FLP4WhTLTXeiEYfM1vA0Z1Lz/1bJ+i45OxaHCIkopPEzOwdv7V
         hM0+8OVNT7WAfeJuiRT8rYZW5YJUiMzaO8tLHA93zd4c4oFoOBLdHSgOyD6wtfBC6EqZ
         Rc2oOJto/DlMfD81JmayGrh4+162WoOKw7nwvZPxyoBxLfhtMMJFydzUbqhePATniBAN
         dQIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=qYCaqNayQbLezcMPa02MlxdUusShwR3XxgN13G0TFtU=;
        b=D/SV0p6q0RSpqUtgpVOwkxebL4yt8ewGGBVsvNLcgOBc7+D3yaSboHZndiguW1JHtT
         V3ZYoFcjr43rG+5raXGnNcMKrOv266ouqzoDO24/5MKWB3qN/tjnoOkf3R48Uv/wiZAe
         rVwpBHGX26zGtCu/e08AuYgaWgc0msxIPrOgWwopljXw3jtdDYwYvZB0dG1ZC4S16ntT
         G3S5yMf3rZ9VFYyqmT6P0rhzmbQG7VC3nsG9negzfg7u5JlYNq2QBXHY5SZyIbtN9Lco
         +5HcBvpPEpl/iEJnefMaccgSQq/C/W4rP4yJgaawoEQTa9dBFd2KsSl9FckkorZuwomV
         9uiQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 46.44.180.42 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 46.44.180.42 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Johannes Thumshirn <jthumshirn@suse.de>,
	Hannes Reinecke <hare@suse.com>,
	Bart Van Assche <bart.vanassche@wdc.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH 4.16 51/68] scsi: scsi_dh: Dont look for NULL devices handlers by name
Date: Tue, 17 Apr 2018 17:58:04 +0200
Message-Id: <20180417155751.422046299@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180417155749.341779147@linuxfoundation.org>
References: <20180417155749.341779147@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598009816916067731?=
X-GMAIL-MSGID: =?utf-8?q?1598009816916067731?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Johannes Thumshirn <jthumshirn@suse.de>

commit 2ee5671e3ae35e53bb5a53a89ac8f033e4b1721f upstream.

Currently scsi_dh_lookup() doesn't check for NULL as a device name. This
combined with nvme over dm-mpath results in the following messages
emitted by device-mapper:

 device-mapper: multipath: Could not failover device 259:67: Handler scsi_dh_(null) error 14.

Let scsi_dh_lookup() fail fast on NULL names.

[mkp: typo fix]

Cc: <stable@vger.kernel.org> # v4.16
Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>
Reviewed-by: Hannes Reinecke <hare@suse.com>
Reviewed-by: Bart Van Assche <bart.vanassche@wdc.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/scsi/scsi_dh.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/scsi/scsi_dh.c
+++ b/drivers/scsi/scsi_dh.c
@@ -112,6 +112,9 @@ static struct scsi_device_handler *scsi_
 {
 	struct scsi_device_handler *dh;
 
+	if (!name || strlen(name) == 0)
+		return NULL;
+
 	dh = __scsi_dh_lookup(name);
 	if (!dh) {
 		request_module("scsi_dh_%s", name);

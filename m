Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELue6qQagIoNWQDBwBqIyF7z5ygaeYRV6b1GukwxCHn/ErZcMvVJPJAGFnUZItkrOtffxmHo
ARC-Seal: i=1; a=rsa-sha256; t=1521483973; cv=none;
        d=google.com; s=arc-20160816;
        b=luPhnTRwMpLnpuOej6ArvpOHlKlLUNXIBdvFXx8eEbEYlq/08JlM01JoJYOUKoXxwy
         f5QQYrapAfQKUUxIqRpVAG4DgiJ3zm3VxnIOQ+MJfrknydtIQqIqAvsZ+TVuIcnnegBU
         dxmGKXTjRS8N+aDJ1knUyhuCABR9l7c2ZbySWb4nIeFRnyTTc4lfDXx8+G6T/3RePDhT
         jhhW7yDW0To/siEy8l3d2mCnALgArAIlSaoZZT6g7EAYexJJnWiOsKalEHGU+xx7cZ7Z
         CLg83K2DiAPyKIg4Hz+FiwJIcwmdVQH4SWBC76JYKyZBLNOvjwJDH2Cnncpef/5PheCS
         olVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=wP3NJRl0hUl7yjgr+hMQKVwKG3zqHu++L7uVg8IqVWc=;
        b=P2nfBBD1VvHo2TGqxwpW1RRzNE5pdnCwwyGgCHfGO0Bg74iCHH9S4rHqKEfIdcgaHo
         kv8Yr/SDNDd1WZ18x+JGxCtK0G7XpMaXQSC+8owQluH6X1EtT/1K14SObA7+AuDoSBzC
         WdQ3jikmUGzNgNA861CwSD9MAXxd/dzFnF/dkkW53UEnIGg4Iv07zR5gnNAg2TBvCl9c
         YxLRrdNcYo/5NfN3hld9oSvrqJrzrP98B6Qmjo+gjhRJJhu6OZ3YjQt98ED8FfH6JMCP
         xkbtiNF6BAAmHYC7lcHb2pSwUGUfYJECA8LUXKeHL5OUGlE3DXDgz7bQ1ZiFBpL2w9SW
         avDg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Li Dongyang <dongyang.li@anu.edu.au>,
	Jason Ozolins <jason.ozolins@hpe.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 186/241] scsi: ses: dont ask for diagnostic pages repeatedly during probe
Date: Mon, 19 Mar 2018 19:07:31 +0100
Message-Id: <20180319180758.850617113@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319180751.172155436@linuxfoundation.org>
References: <20180319180751.172155436@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595391579494891330?=
X-GMAIL-MSGID: =?utf-8?q?1595391579494891330?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Li Dongyang <dongyang.li@anu.edu.au>


[ Upstream commit 9c0a50022b8ac7e863e6ec8342fa476fe5d1d75c ]

We are testing if there is a match with the ses device in a loop by
calling ses_match_to_enclosure(), which will issue scsi receive
diagnostics commands to the ses device for every device on the same
host.  On one of our boxes with 840 disks, it takes a long time to load
the driver:

[root@g1b-oss06 ~]# time modprobe ses

real	40m48.247s
user	0m0.001s
sys	0m0.196s

With the patch:

[root@g1b-oss06 ~]# time modprobe ses

real	0m17.915s
user	0m0.008s
sys	0m0.053s

Note that we still need to refresh page 10 when we see a new disk to
create the link.

Signed-off-by: Li Dongyang <dongyang.li@anu.edu.au>
Tested-by: Jason Ozolins <jason.ozolins@hpe.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/scsi/ses.c |   11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

--- a/drivers/scsi/ses.c
+++ b/drivers/scsi/ses.c
@@ -578,13 +578,16 @@ static void ses_enclosure_data_process(s
 }
 
 static void ses_match_to_enclosure(struct enclosure_device *edev,
-				   struct scsi_device *sdev)
+				   struct scsi_device *sdev,
+				   int refresh)
 {
+	struct scsi_device *edev_sdev = to_scsi_device(edev->edev.parent);
 	struct efd efd = {
 		.addr = 0,
 	};
 
-	ses_enclosure_data_process(edev, to_scsi_device(edev->edev.parent), 0);
+	if (refresh)
+		ses_enclosure_data_process(edev, edev_sdev, 0);
 
 	if (scsi_is_sas_rphy(sdev->sdev_target->dev.parent))
 		efd.addr = sas_get_address(sdev);
@@ -615,7 +618,7 @@ static int ses_intf_add(struct device *c
 		struct enclosure_device *prev = NULL;
 
 		while ((edev = enclosure_find(&sdev->host->shost_gendev, prev)) != NULL) {
-			ses_match_to_enclosure(edev, sdev);
+			ses_match_to_enclosure(edev, sdev, 1);
 			prev = edev;
 		}
 		return -ENODEV;
@@ -727,7 +730,7 @@ static int ses_intf_add(struct device *c
 	shost_for_each_device(tmp_sdev, sdev->host) {
 		if (tmp_sdev->lun != 0 || scsi_device_enclosure(tmp_sdev))
 			continue;
-		ses_match_to_enclosure(edev, tmp_sdev);
+		ses_match_to_enclosure(edev, tmp_sdev, 0);
 	}
 
 	return 0;

Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx49Befqg3rqHdLCewYZFVIufkokWABSRgXEwg/ST1GtcmoAT9MLMzdM3WODaRLKDZznHl5Nb
ARC-Seal: i=1; a=rsa-sha256; t=1524405454; cv=none;
        d=google.com; s=arc-20160816;
        b=uQIjq5l+9rcABrT+I4I6fhWS5KraoDWGyyFw4D+Mu2dTzKxYDsHOfzU3UPcnO4WmyC
         W0skL/zR7s5PyRzP3ZOWf/f7LnDB83qrUE21EKXNSshStHA5NQmPpBuVT/3HXWcdhWsH
         ITcp1QCgUX2mykEbkaUfdCxk/O4o0JMzV9YcHGLF4ZreMkVmrpr/Lwlx1QuAMDhoXmW0
         0sTym/lFVL4kyp0x3pRB7b/PjEr2/siAAplI5y11/2szmT0gxzk7yBiO24SGp3q0pQEz
         OOtBBT3QiGEME+qKVPR6IDuBpLM0mgcoObMQx8mDPCQeOimhmo2QNtQtCsIPOGY3un0r
         oWNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=LLqXmouqxpvj8iM+L7Mt1wVHFlw+eTc5zTdkFhPdb74=;
        b=rPV1hbAKYdmHA22MNJxoF0NF+MTuUaYz+py441iZEtQ9kwn52G+Vuu5CzbVqFrTMko
         fP8PNc6bjRvbUJfbl+TQY6sRV+jKG99xc2K6fs3VPSc2UBwV8WBMvDeoMjQ17D6VNGR3
         XK3M2bQbeNJEIkcXPy6y7SwC8KTyDPODgcZmwcE65Pk2d5RuU4K049EDvmYNwJW7ZJpd
         xHeSDJ6gT6kl2XgEcPI6iMevS3a206FHMGJIbrXSiDTX3YxjB94j9Nj/m5BGFIMD+gFZ
         sX+SinW3qOGLYT5glOWQZeEJXS/mgYrH8N+xqPnAM4dYRL2AmwGP/pd5khquVHY4Ddx4
         OCIQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Ronnie Sahlberg <lsahlber@redhat.com>,
	Steve French <smfrench@gmail.com>
Subject: [PATCH 4.16 045/196] cifs: fix memory leak in SMB2_open()
Date: Sun, 22 Apr 2018 15:51:05 +0200
Message-Id: <20180422135106.402766447@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135104.278511750@linuxfoundation.org>
References: <20180422135104.278511750@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598454973486249608?=
X-GMAIL-MSGID: =?utf-8?q?1598454973486249608?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ronnie Sahlberg <lsahlber@redhat.com>

commit b7a73c84eb96dabd6bb8e9d7c56f796d83efee8e upstream.

Signed-off-by: Ronnie Sahlberg <lsahlber@redhat.com>
Signed-off-by: Steve French <smfrench@gmail.com>
CC: Stable <stable@vger.kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/cifs/smb2pdu.c |    8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

--- a/fs/cifs/smb2pdu.c
+++ b/fs/cifs/smb2pdu.c
@@ -1738,8 +1738,10 @@ SMB2_open(const unsigned int xid, struct
 		rc = alloc_path_with_tree_prefix(&copy_path, &copy_size,
 						 &name_len,
 						 tcon->treeName, path);
-		if (rc)
+		if (rc) {
+			cifs_small_buf_release(req);
 			return rc;
+		}
 		req->NameLength = cpu_to_le16(name_len * 2);
 		uni_path_len = copy_size;
 		path = copy_path;
@@ -1750,8 +1752,10 @@ SMB2_open(const unsigned int xid, struct
 		if (uni_path_len % 8 != 0) {
 			copy_size = roundup(uni_path_len, 8);
 			copy_path = kzalloc(copy_size, GFP_KERNEL);
-			if (!copy_path)
+			if (!copy_path) {
+				cifs_small_buf_release(req);
 				return -ENOMEM;
+			}
 			memcpy((char *)copy_path, (const char *)path,
 			       uni_path_len);
 			uni_path_len = copy_size;

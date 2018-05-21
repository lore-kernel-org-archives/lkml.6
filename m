Return-Path: <SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZrxyb/6GW8A7qiLFRST7P1Vb+PZtsPnRaMBvV1J5CDEwGDbcuQR4HANWVaUJk1yROA5zjSc
ARC-Seal: i=1; a=rsa-sha256; t=1526937269; cv=none;
        d=google.com; s=arc-20160816;
        b=WYIYQ4UMUgbWgB5hhtdrciEE2pPPdiRV36SUZmwn8Uzjlr6wtiGZx4QIxKE90PoqEO
         MbEMfZJKQGmpbfuSDwRpY48rGrmTGk7+9POC7lffKV6Rmo6CiA1HVJcKrb9bWzvrfiEV
         gMU+MHji3L3IdZKIHOagdtl6wTfAQBA+btQjpuD2261xfh/AZtBIHD1V++1dYPgAGUxZ
         I3lbxkRTMlC1K+Ci2Mx5OYjmiGHdB4giV0g7ul9gZ5ZCrEwz/eq5bVFbHnHwaSlXkRqA
         pR6WSEjquYuhnCdqoMDHRDv49YIvCoZo+024aNhNgPDPv9RjoQr7FcaKRl3aHeLbZvDr
         Om9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=QEgk0ZHqeKHDf8XO86GCgh97Ykv6qjGn/N7UWqcGHXc=;
        b=u0er2SflDraWT63zPbDfup1K5qFqX08ECoNA/Jb6J+Cp8EsxkCUO72q+gP5mzNqPQm
         Y9Yvb+Tt4DTpD7gGFE1nMusrFLkjGb6+JOi8w0nrzFMELeQeBeqFwdoQbxX2t4JLEJPs
         v0g6+GD9mqqRWnerEef/6FaAsXkQSoscJxlVqI7zQrcOeUHZ7l+Vv44GC10V377hLhKk
         3j/AxOu6ww5FCSW302IXH15ljJPBTugmyp218WPK4uHg1AHjkH2C+LR9vmjK8Dg2u9W+
         t472B514JPTt+iOc+AXc+gA+C/vow9I99EAhZLnVEoxAfg3A/SXGHZkeYX9RPFHQ4OzK
         0Cjg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=EhXx2u8t;
       spf=pass (google.com: domain of srs0=nia/=ii=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=EhXx2u8t;
       spf=pass (google.com: domain of srs0=nia/=ii=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Wenwen Wang <wang6495@umn.edu>,
	Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.9 08/87] ALSA: control: fix a redundant-copy issue
Date: Mon, 21 May 2018 23:10:44 +0200
Message-Id: <20180521210421.039183160@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180521210420.222671977@linuxfoundation.org>
References: <20180521210420.222671977@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1601109775093453912?=
X-GMAIL-MSGID: =?utf-8?q?1601109775093453912?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Wenwen Wang <wang6495@umn.edu>

commit 3f12888dfae2a48741c4caa9214885b3aaf350f9 upstream.

In snd_ctl_elem_add_compat(), the fields of the struct 'data' need to be
copied from the corresponding fields of the struct 'data32' in userspace.
This is achieved by invoking copy_from_user() and get_user() functions. The
problem here is that the 'type' field is copied twice. One is by
copy_from_user() and one is by get_user(). Given that the 'type' field is
not used between the two copies, the second copy is *completely* redundant
and should be removed for better performance and cleanup. Also, these two
copies can cause inconsistent data: as the struct 'data32' resides in
userspace and a malicious userspace process can race to change the 'type'
field between the two copies to cause inconsistent data. Depending on how
the data is used in the future, such an inconsistency may cause potential
security risks.

For above reasons, we should take out the second copy.

Signed-off-by: Wenwen Wang <wang6495@umn.edu>
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/core/control_compat.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

--- a/sound/core/control_compat.c
+++ b/sound/core/control_compat.c
@@ -400,8 +400,7 @@ static int snd_ctl_elem_add_compat(struc
 	if (copy_from_user(&data->id, &data32->id, sizeof(data->id)) ||
 	    copy_from_user(&data->type, &data32->type, 3 * sizeof(u32)))
 		goto error;
-	if (get_user(data->owner, &data32->owner) ||
-	    get_user(data->type, &data32->type))
+	if (get_user(data->owner, &data32->owner))
 		goto error;
 	switch (data->type) {
 	case SNDRV_CTL_ELEM_TYPE_BOOLEAN:

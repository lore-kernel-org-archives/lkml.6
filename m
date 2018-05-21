Return-Path: <SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZqRyR9gjDnrNWQ9D3OGGERrwNSdG4DWbtjNbguV6AOsTrTCuMnm/0NEQwkus1dQMwghhniE
ARC-Seal: i=1; a=rsa-sha256; t=1526937744; cv=none;
        d=google.com; s=arc-20160816;
        b=ity0C7xDvrCDgeKHu77H0wANafvcvr2vZTCmGzLJ9X/V5GcU87oTvQpLadBOjz6okU
         VzM+wQJWQiD/ZSSPxCD2RYqAZEtIP+V9l6KdDaTTataA+rQ0AYw6UurILYuLvAu7N/zn
         Rl7wHfGxjY0YEvJ9hSxMQmaUqehjrkpHJsv0ASRuTK4pb0U7SYk0/jyUe7Of6wjIfpws
         aY85I56c6Kjda0+8Hj0uzhSRXwlZVUteDrFC7CdUGrC2B1YpTJyfrxww5tvOXPHXVpkW
         Bg1WpYHNetEhpmhyTOK10oeX9rIBeaaACrk6hGBZzMTAjY8oO0z3C8+z7SRet3Jj2mc6
         xwKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=k7HynXXsru5C685nrWOFZtB70800dcuLfgYRr6Qyw/Y=;
        b=nzS6k0hY1HRVI+udKrUirllIDH0MRIITetclTvzPOfCSi+glFfo6uYUjpjFJphpT0T
         9h8xm515P7xBGPxn45AfVVoppLMrIhteIjUE6m2BnuZV+zAYPs8BkO6tokEuxeyfHPOC
         L6VPZpR6S5t7zqELbe6IVakNL/YvlRFgQUPhPCnhnUBY71oYf5ie2ja1rIuAha8lrfhZ
         8Fe1mTEKxGzjGqJCP6N+NP6YAL5ca8kTer5p6FjC4l1HwgvEze1Ma3zuxjMq+rxv0/K2
         tmZYxUR1xpD8vMk73fHEvRbwGkVYPwSEVWAiQV5SFUipCDzaYGOmJVNXtQWiF75+YSEG
         6cbQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=dysU08PY;
       spf=pass (google.com: domain of srs0=nia/=ii=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=dysU08PY;
       spf=pass (google.com: domain of srs0=nia/=ii=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Wenwen Wang <wang6495@umn.edu>,
	Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.16 010/110] ALSA: control: fix a redundant-copy issue
Date: Mon, 21 May 2018 23:11:07 +0200
Message-Id: <20180521210504.859966499@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180521210503.823249477@linuxfoundation.org>
References: <20180521210503.823249477@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1601109775093453912?=
X-GMAIL-MSGID: =?utf-8?q?1601110272177560278?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

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
@@ -396,8 +396,7 @@ static int snd_ctl_elem_add_compat(struc
 	if (copy_from_user(&data->id, &data32->id, sizeof(data->id)) ||
 	    copy_from_user(&data->type, &data32->type, 3 * sizeof(u32)))
 		goto error;
-	if (get_user(data->owner, &data32->owner) ||
-	    get_user(data->type, &data32->type))
+	if (get_user(data->owner, &data32->owner))
 		goto error;
 	switch (data->type) {
 	case SNDRV_CTL_ELEM_TYPE_BOOLEAN:

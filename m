Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/D1g1pbCB3oSTFJJmDT+z0dKYlHlg10sSJg3OoyJ67Z1/RbT++A1gqj8xRtfY2UeuLiTku
ARC-Seal: i=1; a=rsa-sha256; t=1524653043; cv=none;
        d=google.com; s=arc-20160816;
        b=fU+/cClpfADrsQmQQADw6zWRlJ67YZCmzuA3k5tZ6WHWOQOOdy8PqJAeDzODqtUM+9
         hLiAOBZosQ5O9rk337DFjrxiIQsnuQjwTKNH4O/NIYyEsxCkDjTHBoKzzTW3SDfO3SM0
         b+2XCtELgqtJpTJJeOOIaamup3JwkSSxpYWbWhkyZB31QtGqTMh+/rOvgwJTm1TtsapZ
         N6KMNV4taguC8SBsrfbgAiwXuSyAxMhpwTGMofnbqP7jZRoh/8c1GYZDYlHzzxf6nFdu
         1LzKiwzeYPlpEazHnI62uiGorC6+4ZLDcUKZcjDxcBKNORXHLiA70ttJp5YUeomeJfO9
         pxRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=8ujskl5/V7dn6FXonOUsKQvFFqKWn3y4UOyxp7de7KY=;
        b=womRjmyzTx0mRK/TNa5MPtNfio80CUpq1ZUP6KEyH9y6eTfnpbwy0iGFruq6bV6Rqg
         kXbgyduE9EkD/PuDEprIYUnvXZmmXGvYhiGQyqRLs2pLWrTjHTtwBzDfPMDuEgdhgdSw
         u+oqK52gmC8ffK8rhXjW4+8gu0vjjWbqWxYNcrpjSmQd3ZyO2dt3jUjMvLbDRnbIyYVQ
         EyRfoFSttAxOOVzSc6j2ThoVrDLxrFwc6+F1IbUPr7wO4KTjtA02o00j9OaUGE5qEtwm
         wIxvN0wytepUDKRaYoVNem56+f65tpD7zZ1QJmrDXn5o0J0Ru1BNuewqHrxLLOc/5mHH
         VHNA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>,
	Steve French <smfrench@gmail.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 146/183] cifs: silence compiler warnings showing up with gcc-8.0.0
Date: Wed, 25 Apr 2018 12:36:06 +0200
Message-Id: <20180425103248.409714351@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180425103242.532713678@linuxfoundation.org>
References: <20180425103242.532713678@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598714590260890738?=
X-GMAIL-MSGID: =?utf-8?q?1598714590260890738?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Arnd Bergmann <arnd@arndb.de>


[ Upstream commit ade7db991b47ab3016a414468164f4966bd08202 ]

This bug was fixed before, but came up again with the latest
compiler in another function:

fs/cifs/cifssmb.c: In function 'CIFSSMBSetEA':
fs/cifs/cifssmb.c:6362:3: error: 'strncpy' offset 8 is out of the bounds [0, 4] [-Werror=array-bounds]
   strncpy(parm_data->list[0].name, ea_name, name_len);

Let's apply the same fix that was used for the other instances.

Fixes: b2a3ad9ca502 ("cifs: silence compiler warnings showing up with gcc-4.7.0")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Steve French <smfrench@gmail.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/cifs/cifssmb.c |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

--- a/fs/cifs/cifssmb.c
+++ b/fs/cifs/cifssmb.c
@@ -6331,9 +6331,7 @@ SetEARetry:
 	pSMB->InformationLevel =
 		cpu_to_le16(SMB_SET_FILE_EA);
 
-	parm_data =
-		(struct fealist *) (((char *) &pSMB->hdr.Protocol) +
-				       offset);
+	parm_data = (void *)pSMB + offsetof(struct smb_hdr, Protocol) + offset;
 	pSMB->ParameterOffset = cpu_to_le16(param_offset);
 	pSMB->DataOffset = cpu_to_le16(offset);
 	pSMB->SetupCount = 1;

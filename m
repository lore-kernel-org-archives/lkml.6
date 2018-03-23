Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELvIDw1sahJwUGHzP2ILwJyMsuqa7wLbuPcOwzN23XapHCntq+r6KScmHcXJ6fpgljdrlPvD
ARC-Seal: i=1; a=rsa-sha256; t=1521800204; cv=none;
        d=google.com; s=arc-20160816;
        b=CZSA3l+H3m5BKLSpxrnPql5yPydlBoXMd3DlM8q6KV4MS4IVcMNKajvqWT4EHgzdA6
         IDPEPFqqYfaVFAHMW32+d8kRUJ/jBHv+vp60Yc+HA+Vk3exAqNjtLA7WKqwR4xZOygb0
         9IDouDXL0y4YsM5cg71hU237pQ+aO693hxSG9ANkD+P6jkRREugUV/3GoxN2zpyF2cVs
         Y/D1ap+4yqG9CX3KrzqWdFmzihyKPlnm5m4o6wG4ynO21Vg1X67PyEsMoHkOl0h2zIax
         wZbsCQX0xmuTlFQMb1/1sbKO/sp3PsdBBSw6E39zrcvY+uWic+8sg8Z7D4dZRFvvbrji
         TiNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=nzCWLY3V0C6PIV0nKvMtraF10iSVNu2ARmgwyQLsFlA=;
        b=Yb321xH9WMRM8N4qIQNUe1N2n/fEtf3oM1FmoDcKkcB393Bg9XYe+qRnyamT75vBye
         yWqw/YhfjLDaI0Gjg/tV0L3WYQjnBBIrrJ++SPgOzQr+Dno7kRFdaC+VsnBDNOWQLPLk
         PLST/r4Vf+IgA+xG3oQDFIFtFRbrNeNjdBG8wG1W0DsoL8v7UudjF5Y1Uihe7nteaUcV
         qt/A/EEGgPI0KWw3jQQ4Iersfd0vq4bp6NECkqA5s9Jmq8ZGTztjFvGHPJWkVlwxNXXS
         XDes3KHqvzkkMpQSlIpyk27WHiqZQh1KhcYCA26tbGEknuULOb4XF7eYKP578D9zwDVj
         W7gA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Dan Carpenter <dan.carpenter@oracle.com>,
	Steve French <smfrench@gmail.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 69/97] cifs: small underflow in cnvrtDosUnixTm()
Date: Fri, 23 Mar 2018 10:54:56 +0100
Message-Id: <20180323094201.475954266@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180323094157.535925724@linuxfoundation.org>
References: <20180323094157.535925724@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595722782804063589?=
X-GMAIL-MSGID: =?utf-8?q?1595723171093684881?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dan Carpenter <dan.carpenter@oracle.com>


[ Upstream commit 564277eceeca01e02b1ef3e141cfb939184601b4 ]

January is month 1.  There is no zero-th month.  If someone passes a
zero month then it means we read from one space before the start of the
total_days_of_prev_months[] array.

We may as well also be strict about days as well.

Fixes: 1bd5bbcb6531 ("[CIFS] Legacy time handling for Win9x and OS/2 part 1")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Steve French <smfrench@gmail.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/cifs/netmisc.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/fs/cifs/netmisc.c
+++ b/fs/cifs/netmisc.c
@@ -980,10 +980,10 @@ struct timespec cnvrtDosUnixTm(__le16 le
 		cifs_dbg(VFS, "illegal hours %d\n", st->Hours);
 	days = sd->Day;
 	month = sd->Month;
-	if ((days > 31) || (month > 12)) {
+	if (days < 1 || days > 31 || month < 1 || month > 12) {
 		cifs_dbg(VFS, "illegal date, month %d day: %d\n", month, days);
-		if (month > 12)
-			month = 12;
+		days = clamp(days, 1, 31);
+		month = clamp(month, 1, 12);
 	}
 	month -= 1;
 	days += total_days_of_prev_months[month];

Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x224uDK/xYqePaTFgMNPhJnOmQzkr66KnIr/luK3S3RAhB6bXZ8RBN/E+/t1D07s88oLrx+EA
ARC-Seal: i=1; a=rsa-sha256; t=1517591291; cv=none;
        d=google.com; s=arc-20160816;
        b=iVtCuJ1KotUGxv4uP8wu84i8BOFxBXlPQinrYYCkiwRyUsQd/7CFAemmOxxhftURPq
         dx6HsRpRyk8Lf2o5Q8JWuYmZC1xK/TfkvYspmBMM7dklfm00hiZzcfwxVO+mHHYJ9jkg
         /UoeneLKqmloR67rorIbP6nRTLcpKrs723mbM8NwQc7td+BD2W+7IDzWBg8BrkjtDgPo
         0UZf+holEbTEuv3Idrlmd3v8HrC2HSVKGbhKiCNnM4ng2XAg4oMEmhTiM8VeOdU3tl88
         zhBg8x1HmxHzwFwWMc0Wr6nn+QtHs6bFbeaA5BDMleFI99kcXsONE7HpTBH5CXtZ6IiW
         XMEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=8ZyaLLjrTK7rYbgEKjRNOG7bwhZji4imSkWtPXZKc50=;
        b=w9Pg4bAIMHc3Mf+WcawOJwyfrit9Dldxtq9KVVRnAIryDv46IcGDcuLpiDwdThnrXG
         /ezcslY3mhUrl4uI22+U5axjnKBC9N0/5/S+F4QgichQGC8GJm103A1MT9iEdxFWkpwj
         P9QsqsIfk0sxfZlRrEfUJOT3zBplRbjFBaDlv54E9Yedqt6Q5RqjH55F5928Nr9PETG6
         LppwSrHBgRTDJ/vTznEuWPRinzvwtdEEPbRDYV9/2EbJfpg/fqbDPlY6t3yfdsVZ6eiH
         tjntOBcSCoyzu3Cl1SBy+49lu1p/YFT+5ncBuQ7YIT9hAkuDxyTK3n88ykCrykgVpNCn
         bbAQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Raghava Aditya Renukunta <RaghavaAditya.Renukunta@microsemi.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH 4.14 028/156] scsi: aacraid: Fix udev inquiry race condition
Date: Fri,  2 Feb 2018 17:56:49 +0100
Message-Id: <20180202140841.576350772@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180202140840.242829545@linuxfoundation.org>
References: <20180202140840.242829545@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1591309805673552556?=
X-GMAIL-MSGID: =?utf-8?q?1591309805673552556?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Raghava Aditya Renukunta <RaghavaAditya.Renukunta@microsemi.com>

commit f4e8708d3104437fd7716e957f38c265b0c509ef upstream.

When udev requests for a devices inquiry string, it might create multiple
threads causing a race condition on the shared inquiry resource string.

Created a buffer with the string for each thread.

Fixes: 3bc8070fb75b3315 ([SCSI] aacraid: SMC vendor identification)
Signed-off-by: Raghava Aditya Renukunta <RaghavaAditya.Renukunta@microsemi.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/scsi/aacraid/aachba.c |   16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

--- a/drivers/scsi/aacraid/aachba.c
+++ b/drivers/scsi/aacraid/aachba.c
@@ -913,8 +913,16 @@ static void setinqstr(struct aac_dev *de
 	memset(str, ' ', sizeof(*str));
 
 	if (sup_adap_info->adapter_type_text[0]) {
-		char *cp = sup_adap_info->adapter_type_text;
 		int c;
+		char *cp;
+		char *cname = kmemdup(sup_adap_info->adapter_type_text,
+				sizeof(sup_adap_info->adapter_type_text),
+								GFP_ATOMIC);
+
+		if (!cname)
+			return;
+
+		cp = cname;
 		if ((cp[0] == 'A') && (cp[1] == 'O') && (cp[2] == 'C'))
 			inqstrcpy("SMC", str->vid);
 		else {
@@ -923,7 +931,7 @@ static void setinqstr(struct aac_dev *de
 				++cp;
 			c = *cp;
 			*cp = '\0';
-			inqstrcpy(sup_adap_info->adapter_type_text, str->vid);
+			inqstrcpy(cname, str->vid);
 			*cp = c;
 			while (*cp && *cp != ' ')
 				++cp;
@@ -937,8 +945,8 @@ static void setinqstr(struct aac_dev *de
 			cp[sizeof(str->pid)] = '\0';
 		}
 		inqstrcpy (cp, str->pid);
-		if (c)
-			cp[sizeof(str->pid)] = c;
+
+		kfree(cname);
 	} else {
 		struct aac_driver_ident *mp = aac_get_driver_ident(dev->cardtype);
 

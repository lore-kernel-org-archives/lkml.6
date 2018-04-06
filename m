Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48IWkmpvvrI32beDXAmhXZIq/G+uLGnN7NBXw9Ml3V0mmFtBAOwMIe4mUfrzK34e06pL5GJ
ARC-Seal: i=1; a=rsa-sha256; t=1523021589; cv=none;
        d=google.com; s=arc-20160816;
        b=pWbpnITVQmeEN+QrX+w0mpRP+yj99GRVicasw2Y2BwMTQrF9K37tQXKokUZgdoe7OF
         a3YTU1tpJcxYeYLm1lZGet5++5Q5qRXfpuEzE4CapxCwd5tRwb6g7V9bXiv/KxqHhWNO
         Q9rxe5E0FQk8b9uVBkJj/vghumaBwKsUwuIraMtErsm7PJtj5Hi1jc5y0hLXEx31Ek1e
         9nDTTdg9vfoYprHCqFIJZ4jtM6+2vZsVeLO8t6CEPDDtAUqiRppGKVYJzt/fYAVkPm3+
         hjhJe5/1hyHLyA9YEy+Kath/+ob1ma16pfhjR01BlOPr+ciXvqGjW/Jlsj0kaRwavjRi
         fppg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=TfBvN/BD+ri3LwNj0TshUqV+T99AIYjuDlbnU8jR2EA=;
        b=on2Um/G9hAtuPWPCC/IQulFrh+I5jd+tCBe97RKlWhgZ5M7eUIntLlM2NsmEYhYb67
         SlfelRYI85RlgIaXWU562VC7ob9+HbX8W5jpU54LpCgIv8So+38D9BYJfcv51ijfjkSy
         JqLGB2CnmJWciwqI7nChIsLMS65w4kkcv5ScYcoZYDgO6rTNccSsLCq4SwI+U7D0UzgE
         EtNQCfv0H/rm4IDzvseTLmcLnnQ3ppGlGNeXQ4nLhdnttCV+cfUDdMYaduEyUB1cW/EY
         n0HhMGmoOvBTsn8QLuMiuZZxDyYuYSSJfKuibeQrUKCpsUDTSeTPnRHBPBKne4kio7S+
         jG4Q==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Matthias Kaehlcke <mka@chromium.org>,
	Paul Moore <paul@paul-moore.com>,
	Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH 4.9 019/102] selinux: Remove unnecessary check of array base in selinux_set_mapping()
Date: Fri,  6 Apr 2018 15:23:00 +0200
Message-Id: <20180406084334.303108613@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180406084331.507038179@linuxfoundation.org>
References: <20180406084331.507038179@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597003774688884357?=
X-GMAIL-MSGID: =?utf-8?q?1597003886576519954?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Matthias Kaehlcke <mka@chromium.org>

commit 342e91578eb6909529bc7095964cd44b9c057c4e upstream.

'perms' will never be NULL since it isn't a plain pointer but an array
of u32 values.

This fixes the following warning when building with clang:

security/selinux/ss/services.c:158:16: error: address of array
'p_in->perms' will always evaluate to 'true'
[-Werror,-Wpointer-bool-conversion]
                while (p_in->perms && p_in->perms[k]) {

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
Signed-off-by: Paul Moore <paul@paul-moore.com>
Cc: Nathan Chancellor <natechancellor@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 security/selinux/ss/services.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -155,7 +155,7 @@ static int selinux_set_mapping(struct po
 		}
 
 		k = 0;
-		while (p_in->perms && p_in->perms[k]) {
+		while (p_in->perms[k]) {
 			/* An empty permission string skips ahead */
 			if (!*p_in->perms[k]) {
 				k++;

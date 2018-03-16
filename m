Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELuBJWhdpL65cTVWWZYhbXgBlXMpUM+lTsImJPj70VYw7MDg1wxWeFhEzjmk35YO1HkGzd0A
ARC-Seal: i=1; a=rsa-sha256; t=1521214625; cv=none;
        d=google.com; s=arc-20160816;
        b=B9zNunCS3dg6SzmqyyIX1krH3w1+QQ8kRLa5VmDrgzmHLCGHUjmBRtMeuYIYGfip3m
         6mBxXyGtRR+STCitlijjv5eCs4FGe1sJrPmx9Q5wH5gf9GncEGuJCY3s8nxlh48MTEuN
         uyxVE0Y87KJUYp7ffYvfXeVWc9CdxGIS48y4vVZp+NDYPqyVMz87O3PEiLh7OqAW6Z+n
         TJDOSNJwebvZnpVC1c6jfejoxeKd7i+70v7NXLzR1lNjipKXCpxbGjEVCgH1WNKCpth1
         AeNHdb6K5d031QU9vRdUQ/Gy/BoFIVuF5sTE9Z0ol5IipYFTqRJXWRmEWCxXgodsZiGz
         IhWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=qYedttp88YpCjoY/sy9IjTpoOO+CRh07cHD4W2s/C64=;
        b=ay9sfL2G2V6H7xlyA7Qi3vE3gbIbFAbOTuR0ec2TOVCj6zPFdFCrARhdNHlGTgSPcf
         +KztZj2mt9zxcAgAdsgUDhr/oymYkKPURv/Yco6w6LNao984QsEOXblSL0zDdRSVl9bp
         mpVL52aUSZiSk6vRP7pogB5oIkjSd3j+y1GZw660LHLuGc21GlQCaBUiiTM7sGS9go8/
         Rwt5quuC+0k17QQCXPwDJG5uNN2O5qtXjUA+QH9ReXfoxIsq8KXfFGpvAowrl6AHp7if
         eL385GfS1QHObiZFIXoKe6BQVrkRKKPdJ52w6RitEhLw4COPIG6C61ZDNzjMzojvAaLI
         2WJw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Thomas Richter <tmricht@linux.vnet.ibm.com>,
	Hendrik Brueckner <brueckner@linux.vnet.ibm.com>,
	Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>,
	Heiko Carstens <heiko.carstens@de.ibm.com>,
	Martin Schwidefsky <schwidefsky@de.ibm.com>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 073/109] perf annotate: Fix objdump comment parsing for Intel mov dissassembly
Date: Fri, 16 Mar 2018 16:23:42 +0100
Message-Id: <20180316152333.957937973@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180316152329.844663293@linuxfoundation.org>
References: <20180316152329.844663293@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595109147936331066?=
X-GMAIL-MSGID: =?utf-8?q?1595109147936331066?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Thomas Richter <tmricht@linux.vnet.ibm.com>


[ Upstream commit 35a8a148d8c1ee9e5ae18f9565a880490f816f89 ]

The command 'perf annotate' parses the output of objdump and also
investigates the comments produced by objdump. For example the
output of objdump produces (on x86):

23eee:  4c 8b 3d 13 01 21 00 mov 0x210113(%rip),%r15
                                # 234008 <stderr@@GLIBC_2.2.5+0x9a8>

and the function mov__parse() is called to investigate the complete
line. Mov__parse() breaks this line into several parts and finally
calls function comment__symbol() to parse the data after the comment
character '#'. Comment__symbol() expects a hexadecimal address followed
by a symbol in '<' and '>' brackets.

However the 2nd parameter given to function comment__symbol()
always points to the comment character '#'. The address parsing
always returns 0 because the character '#' is not a digit and
strtoull() fails without being noticed.

Fix this by advancing the second parameter to function comment__symbol()
by one byte before invocation and add an error check after strtoull()
has been called.

Signed-off-by: Thomas Richter <tmricht@linux.vnet.ibm.com>
Reviewed-by: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
Acked-by: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Fixes: 6de783b6f50f ("perf annotate: Resolve symbols using objdump comment")
Link: http://lkml.kernel.org/r/20171128075632.72182-1-tmricht@linux.vnet.ibm.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/perf/util/annotate.c |    8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -323,6 +323,8 @@ static int comment__symbol(char *raw, ch
 		return 0;
 
 	*addrp = strtoull(comment, &endptr, 16);
+	if (endptr == comment)
+		return 0;
 	name = strchr(endptr, '<');
 	if (name == NULL)
 		return -1;
@@ -436,8 +438,8 @@ static int mov__parse(struct arch *arch,
 		return 0;
 
 	comment = ltrim(comment);
-	comment__symbol(ops->source.raw, comment, &ops->source.addr, &ops->source.name);
-	comment__symbol(ops->target.raw, comment, &ops->target.addr, &ops->target.name);
+	comment__symbol(ops->source.raw, comment + 1, &ops->source.addr, &ops->source.name);
+	comment__symbol(ops->target.raw, comment + 1, &ops->target.addr, &ops->target.name);
 
 	return 0;
 
@@ -481,7 +483,7 @@ static int dec__parse(struct arch *arch
 		return 0;
 
 	comment = ltrim(comment);
-	comment__symbol(ops->target.raw, comment, &ops->target.addr, &ops->target.name);
+	comment__symbol(ops->target.raw, comment + 1, &ops->target.addr, &ops->target.name);
 
 	return 0;
 }

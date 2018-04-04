Return-Path: <ben.hutchings@codethink.co.uk>
X-Google-Smtp-Source: AIpwx49x64JZ2KDY3+4d2ontRrv0ThS8rNCnU1rnDH3RpIPJvO0SOPXXeSZ/LJixp04iHtbztNVb
ARC-Seal: i=1; a=rsa-sha256; t=1522874332; cv=none;
        d=google.com; s=arc-20160816;
        b=MDqqtEiyAUN/2VPbBjnEQwsxYWnz7KmkfrQKp0xKpxnB7Gwps4nBYfosR9QjWfqe9A
         UAgbdlQ5rXsRV0frHntHyiu7tEqzzVdiVUxaq7U52ztR+vJ+X7WIaV5TePxRMCakISnX
         YrtNW3BYkU13ulOMTYdwGC14RLN/6Kc7S1yHdjxGE/zabe9gK/kq4eLMsZAgomDEzl8d
         BIFLQuKrMwvvqqE6s8nqU5Op05paQIolMAjVM/V9i4yPdQHHno3gZ/TRLSvL8m4ZMi1Q
         0ZsSrcY8Db11pF2TmaDeHXiJIRgkVoSmF52WN51NKQ350DcPcqUMZLHwZeG0yhX7tlVV
         aM+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=8d8q423GvYIzGfZuk72vmpKXIiKL4Oiy4Ao+dqPebgk=;
        b=Q3pemva06E8wPOWXyrXXqFcXZTUQ2bQ/XZr83e+edLKTsFzh3w5H1xTxlDCznDkoBY
         71W0XpzldmyTG3EG8KY5uq2sCA2sWxWO1n9Ohj5UUlXkdUlyoyI5Yj5NXay1EbAuOHoK
         WASze9XSqh9PCI20PI+YNeF94rDa9Y4uacN0kVDT1NLK01y9zZ7iDegPIWIfN8VQ2rdd
         RDPSQLwiK56cCbs4qkxvmI+92iqS01fv+74FAqAeimaD/mff2kRDlL3wjNKIY6HLHon8
         7h4qE105pNpNmiBisJS1H2JWlNUbS+FJGRGK0S+Pr/Fwsl5FMaR6VaUvdt/aGIc1yVd6
         8snw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of ben.hutchings@codethink.co.uk designates 176.9.8.82 as permitted sender) smtp.mailfrom=ben.hutchings@codethink.co.uk;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=codethink.co.uk
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of ben.hutchings@codethink.co.uk designates 176.9.8.82 as permitted sender) smtp.mailfrom=ben.hutchings@codethink.co.uk;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=codethink.co.uk
Date: Wed, 4 Apr 2018 22:38:49 +0200
From: Ben Hutchings <ben.hutchings@codethink.co.uk>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Luis R. Rodriguez" <mcgrof@kernel.org>
Cc: Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH driver-core 2/2] test_firmware: fix setting old custom fw
 path back on exit, second try
Message-ID: <20180404203848.3txsangsvaxtxsu4@xylophone.i.decadent.org.uk>
References: <20180404203712.zecit6po44qsde4c@xylophone.i.decadent.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180404203712.zecit6po44qsde4c@xylophone.i.decadent.org.uk>
User-Agent: NeoMutt/20170113 (1.7.2)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596849475289780977?=
X-GMAIL-MSGID: =?utf-8?q?1596849475289780977?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Commit 65c79230576 tried to clear the custom firmware path on exit by
writing a single space to the firmware_class.path parameter.  This
doesn't work because nothing strips this space from the value stored
and fw_get_filesystem_firmware() only ignores zero-length paths.

Instead, write a null byte.

Fixes: 0a8adf58475 ("test: add firmware_class loader test")
Fixes: 65c79230576 ("test_firmware: fix setting old custom fw path back on exit")
Signed-off-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
Acked-by: Luis R. Rodriguez <mcgrof@kernel.org>
Cc: stable <stable@vger.kernel.org>
---
 tools/testing/selftests/firmware/fw_lib.sh | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/firmware/fw_lib.sh b/tools/testing/selftests/firmware/fw_lib.sh
index 9ea31b57d71a..962d7f4ac627 100755
--- a/tools/testing/selftests/firmware/fw_lib.sh
+++ b/tools/testing/selftests/firmware/fw_lib.sh
@@ -154,11 +154,13 @@ test_finish()
 	if [ "$HAS_FW_LOADER_USER_HELPER" = "yes" ]; then
 		echo "$OLD_TIMEOUT" >/sys/class/firmware/timeout
 	fi
-	if [ "$OLD_FWPATH" = "" ]; then
-		OLD_FWPATH=" "
-	fi
 	if [ "$TEST_REQS_FW_SET_CUSTOM_PATH" = "yes" ]; then
-		echo -n "$OLD_FWPATH" >/sys/module/firmware_class/parameters/path
+		if [ "$OLD_FWPATH" = "" ]; then
+			# A zero-length write won't work; write a null byte
+			printf '\000' >/sys/module/firmware_class/parameters/path
+		else
+			echo -n "$OLD_FWPATH" >/sys/module/firmware_class/parameters/path
+		fi
 	fi
 	if [ -f $FW ]; then
 		rm -f "$FW"
-- 
2.16.2

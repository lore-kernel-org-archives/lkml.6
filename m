Return-Path: <SRS0=4In3=H3=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZoJC4Zji1Rvf5usOcD2zGkct8XsUbmKTEEttzohMuRbvIfSj9UecGgKC9t5vtDIdRVZTcJr
ARC-Seal: i=1; a=rsa-sha256; t=1525767375; cv=none;
        d=google.com; s=arc-20160816;
        b=u0d1EUFTvLOL+7eXqMkdCtlolyQRDtZy7x8hkQu4za1mP/fszp4QUTPDHeLtnwu/Fq
         mpdD3eyE8ea4Hb+M4seG1i5LaXVSy1rmVkcwibhT4V8rKhBKb/qjjV3l/ogG8nNdYU7p
         dVomz2yxMmwbjCum80QUVQV2lx5DbID8u2VyEqTbWlzUp7H958+H7lth43Eh6POVjh49
         UDWTfdGXGXjfxFuzCJP2KD3IB8fVajY1/X7upnpxtYVJnMT8cH6o7hq+V80WkxkiHC4S
         4HbbyFvxc1g1Zx0wg7BJXXDCljcskcWCE4RblX+6zkWRbKpkbHX4j0gTJ8sZdVmNGHvU
         f77Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=MVapo9SikW6H1OOAUV9KiYyCdYcIjJM9UozA66NGlhk=;
        b=Y5/EZi1ARbKLTjrYKLotEQYmdKBPkKJDmxC65b+VJiStUILlXBnwSw1oPkIc2GVNkk
         bIjSbMMl43mWHXCNa5nk2HrZJb0HtZPdesEwKXayN7S+qgcpqhMAwMkfNQUdsaC90ZNg
         RyeV5RFUcw2X8l7+B4I3tzilxPdRhoEBsWoPUV6sjTwzi3NiO25IWbBMFQ4JAvaDgY4b
         8qNloRZzz0hKdW7TDLwkecIsf7Z0yBFBwAuoxbKsJD9jQtYnbGj/pSnx5X6KVu/p4+AS
         LRopc0ZWxPzVLEvRyFCcRXM7T/JVSdA9z3IArxl3KVpOOCkik4NUObaZl1ScStFM5uZ+
         Dy9w==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=RljHBPFU;
       spf=pass (google.com: domain of srs0=4in3=h3=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4In3=H3=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=RljHBPFU;
       spf=pass (google.com: domain of srs0=4in3=h3=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4In3=H3=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Ben Hutchings <ben.hutchings@codethink.co.uk>,
	"Luis R. Rodriguez" <mcgrof@kernel.org>
Subject: [PATCH 4.14 32/43] test_firmware: fix setting old custom fw path back on exit, second try
Date: Tue,  8 May 2018 10:10:51 +0200
Message-Id: <20180508074008.976173588@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180508074003.984433784@linuxfoundation.org>
References: <20180508074003.984433784@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1599882920358524715?=
X-GMAIL-MSGID: =?utf-8?q?1599883051294834604?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ben Hutchings <ben.hutchings@codethink.co.uk>

commit e538409257d0217a9bc715686100a5328db75a15 upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>


---
 tools/testing/selftests/firmware/fw_filesystem.sh |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

--- a/tools/testing/selftests/firmware/fw_filesystem.sh
+++ b/tools/testing/selftests/firmware/fw_filesystem.sh
@@ -46,9 +46,11 @@ test_finish()
 		echo "$OLD_TIMEOUT" >/sys/class/firmware/timeout
 	fi
 	if [ "$OLD_FWPATH" = "" ]; then
-		OLD_FWPATH=" "
+		# A zero-length write won't work; write a null byte
+		printf '\000' >/sys/module/firmware_class/parameters/path
+	else
+		echo -n "$OLD_FWPATH" >/sys/module/firmware_class/parameters/path
 	fi
-	echo -n "$OLD_FWPATH" >/sys/module/firmware_class/parameters/path
 	rm -f "$FW"
 	rmdir "$FWPATH"
 }

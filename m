Return-Path: <SRS0=4In3=H3=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZo8xbW7TObE3K1XCkmjOD10fa5HSK/08XchqlfK9Rjonm2vDJciZdacfO6Z6UszmPZjVENN
ARC-Seal: i=1; a=rsa-sha256; t=1525767249; cv=none;
        d=google.com; s=arc-20160816;
        b=XXV2aTsYZoBUPFYAVKY9/8AieKwqNHrllgzgPmNbzT9416QrI0v8/8g0r1w91sRMkv
         xGKdQeEuarQYLcLGFPqD2eUv763HPFtUMkUq9ntA4JODKt6eDK83JbotQgYB7FhlQ2PJ
         A3bNiT4FebQuyRiB1TDW/j1StvCwJ5NjmqQpexmA1qPe6Epv18uCy3tbCBBqmhF5HjrG
         Fi2+Oi4HvjfBPG3rY4BAvDzpGWR7vZeWJW7sr8FHKH/kKhSCcQBCFg76HqrFZXVIpgqc
         93U4eftGQkkQ777vt+AzLoe7dSYfzIwromolPldHvEzd6TFa2DTKpmu1xeMx6+dxDHjM
         BJBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=p8nRvGTNgYKVtDgzMdrhYr0HW+5L8IcnFkvmDfxjFts=;
        b=cUX5nOVxO9zRO5VkUuSYHYeLpdr6mxdzaMt/pDOZiTaGgN2ZaSR28Glza5xVt4WMAM
         6ur5Yf+x/f0sx8bBAOosQr95Ol9ruZYpovKr0OKhHVevu05e7ICVdOPF7BjC12tKeNeJ
         JUjSiWNulphlcpU77uSAhzIstn96U5TMVi7taPP+X0Ul9f0AfMHEYO5Jz+tsSWPE/+0b
         kFmZwaAnpBUKps53N11hgjGe/70Zhsil+czmERUWOx8eFUCS4OEaSlOQpiJ1+EoSD5bE
         7sbFtB7Ee7RJtXFa6mBaOVoRjftRQOOdO51QeM0M/6aSc/J4c80JfXdQkJdwKUvO8jSI
         lp1g==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=dj7+W7au;
       spf=pass (google.com: domain of srs0=4in3=h3=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4In3=H3=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=dj7+W7au;
       spf=pass (google.com: domain of srs0=4in3=h3=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4In3=H3=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Ben Hutchings <ben.hutchings@codethink.co.uk>,
	"Luis R. Rodriguez" <mcgrof@kernel.org>
Subject: [PATCH 4.16 34/52] test_firmware: fix setting old custom fw path back on exit, second try
Date: Tue,  8 May 2018 10:10:32 +0200
Message-Id: <20180508073932.870697137@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180508073928.058320984@linuxfoundation.org>
References: <20180508073928.058320984@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1599882920358524715?=
X-GMAIL-MSGID: =?utf-8?q?1599882920358524715?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

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

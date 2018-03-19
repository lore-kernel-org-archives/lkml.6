Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELsoF9wHZ5U+cG9k9v/LjFYKdOV8YMr+tw9ttm6L43s4RQb9dE3L5RX4RoEJA5kuiUSj2/4j
ARC-Seal: i=1; a=rsa-sha256; t=1521483941; cv=none;
        d=google.com; s=arc-20160816;
        b=dVtrqAPPx+hsFSuVzkG/J4JXrvBzUOwmwYoQDI1YrxbOcEjvU+YlVu4QZXVj8IrQjZ
         IiaeVZAUVfKAjeb3HarFlrIKuuHivFSxf5sd4BijviyfDArYlEoclVMAT6DV3fBcp3JX
         p2qbTETOuQjzVHHpFCHB51+2mHwkt9zia+7SvZObO27WI7LUg1uQ0O7aY7qemJkbYMFQ
         jjif6j34Wf1nocx/0XI2Ull0mNurrJ7GHdVeETYLqExhnZZ/5lLZOe73RC4+76X73Io2
         jNk/zxvknlWmcCKIEeyxannU4eY9Gm8RP70XnrRefovlq5iV9Xi0YQCu1oExy33pldde
         SB1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=1XeetnkCtlghs0lRgmyAZ/2uoVQBwZLW0nn+bn4Zt0Q=;
        b=MxR5kMyDyloWHqo2Yoedg2zT5Y4K63XrkxQCYJu+0aOSskIXXMb6JBrgxj1SPx7pEP
         6NIIjwmXoHsKjdAXaE+69IYvVa2EXlu9RdiyO+vAxUmDIq+uUXz8gPM+JYhhbJKKoo88
         1xQpVh8vLA5jh5bEaoGdGFMzEsxYyRUe5FCsuGz+fSY+GwTFvI3X5sPqMP/HvifwjKL4
         3PO4uNbJ7KIpNG05JXRCB+NaeKdvSJXckhY3vvwVesRM/oTgz7fjSBrWo455lv1nFo7W
         WaHjJ30gaDkqd7Qv0XzoQKI/JDcoQSXLsqwGaHHeYJThvYuuWmJ/1WCJuIXn1wegCstf
         XyXA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	"Luis R. Rodriguez" <mcgrof@kernel.org>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 172/241] test_firmware: fix setting old custom fw path back on exit
Date: Mon, 19 Mar 2018 19:07:17 +0100
Message-Id: <20180319180758.280064406@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319180751.172155436@linuxfoundation.org>
References: <20180319180751.172155436@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595390905118986073?=
X-GMAIL-MSGID: =?utf-8?q?1595391545463506058?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: "Luis R. Rodriguez" <mcgrof@kernel.org>


[ Upstream commit 65c79230576873b312c3599479c1e42355c9f349 ]

The file /sys/module/firmware_class/parameters/path can be used
to set a custom firmware path. The fw_filesystem.sh script creates
a temporary directory to add a test firmware file to be used during
testing, in order for this to work it uses the custom path syfs file
and it was supposed to reset back the file on execution exit. The
script failed to do this due to a typo, it was using OLD_PATH instead
of OLD_FWPATH, since its inception since v3.17.

Its not as easy to just keep the old setting, it turns out that
resetting an empty setting won't actually do what we want, we need
to check if it was empty and set an empty space.

Without this we end up having the temporary path always set after
we run these tests.

Fixes: 0a8adf58475 ("test: add firmware_class loader test")
Signed-off-by: Luis R. Rodriguez <mcgrof@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/testing/selftests/firmware/fw_filesystem.sh |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

--- a/tools/testing/selftests/firmware/fw_filesystem.sh
+++ b/tools/testing/selftests/firmware/fw_filesystem.sh
@@ -28,7 +28,10 @@ test_finish()
 	if [ "$HAS_FW_LOADER_USER_HELPER" = "yes" ]; then
 		echo "$OLD_TIMEOUT" >/sys/class/firmware/timeout
 	fi
-	echo -n "$OLD_PATH" >/sys/module/firmware_class/parameters/path
+	if [ "$OLD_FWPATH" = "" ]; then
+		OLD_FWPATH=" "
+	fi
+	echo -n "$OLD_FWPATH" >/sys/module/firmware_class/parameters/path
 	rm -f "$FW"
 	rmdir "$FWPATH"
 }

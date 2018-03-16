Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELsPIMqLtI9VupyhhfwbnT66JrXMhPkh8wP/MD/1SBZqXWtbF+O9iZrA1LhkI+IrpLdrVi55
ARC-Seal: i=1; a=rsa-sha256; t=1521214542; cv=none;
        d=google.com; s=arc-20160816;
        b=CckHk53Qru/3BoesuwGUrLi4092p6a9CWoF648o44ie8V6jAmXXALjIBWbAoFyhQ2j
         PV5oYHvxANq7sDDEmOSl3Nw0cXzmA1Y2IjDrJpJxqE+GO0V3ft8OxY9sKmQrcKpsjFGG
         6loK0f9Dnqkns9luVmZrAfg9VKogsuqqbmFKNK5s4wGqCDiDqm4UCa7eRUOn59vEfTdT
         NEGVCFRY/FVmpd7o+9BiMt5R329qwlMpvSQwdcX3RczDaJ8BlodnuljhU5O9z4jtqv05
         oUiIQCfh21IiKO5vNQ1cwBpr+r5c3WY/ETX+7baYZPFML6fKzEfi2FfhLj3XZWYmrpup
         9r6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=NtKdXYLKy2tVStg10wsUMGyBoJoX0R8J7h1DJDGN6N0=;
        b=guoskimOGzH/vCaGrle2UwvkjoKMcVW59/jBXMeKyJS1/fXNBjiga5uiLt6qxWnKGf
         y638+18/AeE6qicYi5w+/uNsuS1tJc3vdxRbI8quN+4Drdq5OEO1gHyNqy7m2npEI8jw
         9LW0BjxT1fYxyQJKdAcsfcYnfpkz+cWnkGL8U9QyGkOI93C1935a2fokvcyH53SRJ13F
         Fim4wrCa6lvCVqm/v4RJElB1n0ax8lFVEpvrk8m/u6WvprDRKFi9myamHNtZB+Xr0llk
         oF/I6AY0uy2qXCWv2v1PgxzQ026hCkD1gnMRejG36tUSwIyRUeqM/GsqBHOiVxCqO96W
         SmtQ==
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
Subject: [PATCH 4.14 044/109] test_firmware: fix setting old custom fw path back on exit
Date: Fri, 16 Mar 2018 16:23:13 +0100
Message-Id: <20180316152332.364725590@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180316152329.844663293@linuxfoundation.org>
References: <20180316152329.844663293@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595109060118425146?=
X-GMAIL-MSGID: =?utf-8?q?1595109060118425146?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -45,7 +45,10 @@ test_finish()
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

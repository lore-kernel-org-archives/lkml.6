Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELuAq13cWDu+zxcxYd6WscmPsAn1Plh5QKSakF6x6O5XMpGbG/wGBmAEc/mBrzRFnPLtzCH0
ARC-Seal: i=1; a=rsa-sha256; t=1521483331; cv=none;
        d=google.com; s=arc-20160816;
        b=iPv5K7ma3/Zs5RFqGGyEj2r5lYwrBidBioGWpFzlsxM3HDYd1WDminx7l1AKuqoKwX
         eUJydWy603b2HWjbwUUPbuWDP8SwrvzDSvaboYuTamrtY2UDmni0wF9/hRfo7O16mPU+
         XeFeur2ExAeaaNcd6sEo392vh9aw4+12s/iEtwZZ+rjmEdMQcqAMZZOIIc1Io5UMuXL+
         HK9iqr2GdibMxQlIhTg74fXJ1nfUMZiZ66jT+cJcc+pVwrktRFup1g88mtSkqtSAC84T
         vP4jA1CgC6RtSjt3ljQ11DmK9+kumVVUx90OnGqbYq3J/BhwlN2VSoGaNu+uoXMl8xLw
         qP7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=Ru7zZObQZ15/sG6ocuUbvcraN8r7atq87tlAcpV80qw=;
        b=pNjsRCZkR0BYNRblGuVOXzeEwDm9oBOK6uljIFXWP2r7Gu+SDdPbhH8GqdYUJybNXe
         b/0Nvk2twgy8DFO5VxL/jx7oSAm59p3JLEd0h7o+y28+mzdpatEjVKCpHaKf+QM57r+h
         EHXhdPCswE1RKjAoIRat9XUbgDVQA99Axnm01ZujNh7ygNFi2Wvyat3ext/tLlZ3T5Go
         VEaHGTx6267xTnlVvmiJBGMxGiRnbjK1FiQedL6XWM5+FM/QaIu//cjwBN/gixKPddNZ
         24g1Ycmw4tS3fERnwbuuWv0ZTe1i3/mu/M66IZ4vIdOBi+7vKaGizvkPJLGdmnurH3Yp
         oYhw==
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
Subject: [PATCH 4.4 085/134] test_firmware: fix setting old custom fw path back on exit
Date: Mon, 19 Mar 2018 19:06:08 +0100
Message-Id: <20180319171901.557456225@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319171849.024066323@linuxfoundation.org>
References: <20180319171849.024066323@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595390905118986073?=
X-GMAIL-MSGID: =?utf-8?q?1595390905118986073?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

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

Return-Path: <SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZrA8drfPh1UAOggcBYaWrV/ImnZfrsgzOt5Op0pFWxpJN6hhXJDRZsuyXnGT7+5y0MfDLTT
ARC-Seal: i=1; a=rsa-sha256; t=1526280703; cv=none;
        d=google.com; s=arc-20160816;
        b=voi2cUM1/Mg1ER93hqPU7vVHeGYPnxUM29qEZVcdqx4qvdRzv05OwV5RL80eAAEp6p
         gKCnmBhHT8CoJTNv1Tjn+7CGjhYLKNEvwh16gFcT04MIna8dSQ1P95zT6ps1AnIMfUrf
         +o/Xg2FSOWA5OLT1tPyGymJxb/T+E1AbQMEBPzVwIC9ZflsCept9m1FYiChjVa4SIfjO
         8Bf6jcWziaS5CPfIPG5h1AblbCkYSW0tLN6vI9/cY0axGX6lLK65q1fCtjHRBqvwRxM2
         aKg6sbf5iUvRomxzrUbFigq/yPB0n4+UW7kuIGwbI/HECW3GlYtcdqKmyAEus/Z7oAoy
         HSlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=E2eALc5+Pz5bb6fV/wSFM0jO6jbnx0ukiUAEGLs7y1A=;
        b=skivK+NFQTYm3av513FY9P8XXtTymr7lbEkQIK06E0lRtICETH/nUHduLmS4htv4cy
         1rAV78I6M5EV91MOzjN6grLat9cJvzK5PuA305mAKfsCfVDRrRhe+uzhMF4V1eE0oN4C
         Prjk3n64i2KwD/pqnapAsBfhFG2QVDDyCIc/XY4aBt0G3NhaVqOkD3Uxubq3JOz1lIxW
         VE4WTAXAxbLF6wKk3awUez7GIFsuGD7MAQkRRfO4MLIdUYvcGRaiCbpNbp4yuOTh63Zn
         ehSz27uZsVzbHGDd+zgrKQYt3aKHI/eExusNnRa4uYnpqDjfqmQUTvjNHclZS65IGo4w
         0EXw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=un8/Zexk;
       spf=pass (google.com: domain of srs0=ywzk=ib=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=un8/Zexk;
       spf=pass (google.com: domain of srs0=ywzk=ib=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Ben Hutchings <ben.hutchings@codethink.co.uk>,
	"Luis R. Rodriguez" <mcgrof@kernel.org>
Subject: [PATCH 4.4 25/56] test_firmware: fix setting old custom fw path back on exit, second try
Date: Mon, 14 May 2018 08:48:30 +0200
Message-Id: <20180514064757.279100441@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180514064754.853201981@linuxfoundation.org>
References: <20180514064754.853201981@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1600421315436899296?=
X-GMAIL-MSGID: =?utf-8?q?1600421315436899296?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

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
@@ -29,9 +29,11 @@ test_finish()
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

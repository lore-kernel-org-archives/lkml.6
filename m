Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELvFtWifHMePfA3R6frPU+hOEVT2UiguwbARzUeYoEG34QvnEGHb8SbMbb0iKCIg3OgglV1f
ARC-Seal: i=1; a=rsa-sha256; t=1521214882; cv=none;
        d=google.com; s=arc-20160816;
        b=q7bbNJVW+Ww2gV87AEebHo/k3x5IfkaMk+d0giFvE4yu72SgEa3fH87GjbgUOZ1gep
         uBQyvEoe2SzQ5Q0bYEpAGRNuz3dlLDVNJLnCWDEdpoYXhkigXw1t5/xDIQ0L4rJ2MkEE
         +BuNA0ppcFv10ufjd9hd8yVqXkBO5b39JwmmgCt+i66ySCZYGs3LaNfae3uGglc7cEGN
         CvT5n5Tf3TJO6c4MYoXG9l8SkAfTFtxX7xghJhTyOq7zBxMLR9n3AZxaM2ijS65SNF+y
         s73EbSnEtdLrfM1ghZbwQY/JNookKiHvv7HBWEvCmP2IgZL0qzoGaUORAB6uqd81BoOJ
         jvUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=NIBSHVsUzpf29ql4D8L0IHyRQe0Tka+Q+4NbVidNVmg=;
        b=i4C/I2dzyZ5AH+cge5PCtzdYz4d637EA+ciXi3a5OCINglM1TGExFJvGEAvaWyRn1g
         cW/Vo2afNIAF4iKK0zBA7wBiDMOMyKjYFR7oO8C0FOtNR5+NpeT1fls2Kcq1uIxOtpjc
         cnRpacOGVZp/WOLHKVwK1j9hO9nU+f7p0xh71EnbZ2MdJUIld1rXTAre2RJveSjqatZh
         ToH+uPVDYBuuz6ZZALBv/8CjfbyEMLlwLdK6D/d3N2uNLNStPpGb/by1xLN2fx9k++ud
         dSEeclQUcNwlK9XsyOWfZi6sf+fESb2cpzLYlDQlX+NZrKAUF+KLrMZicxEVStQdkyBl
         pgZw==
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
Subject: [PATCH 4.15 052/128] test_firmware: fix setting old custom fw path back on exit
Date: Fri, 16 Mar 2018 16:23:13 +0100
Message-Id: <20180316152339.452678554@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180316152336.199007505@linuxfoundation.org>
References: <20180316152336.199007505@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595109060118425146?=
X-GMAIL-MSGID: =?utf-8?q?1595109416767345910?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

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

Return-Path: <daniel.diaz@linaro.org>
ARC-Seal: i=1; a=rsa-sha256; t=1517955837; cv=none;
        d=google.com; s=arc-20160816;
        b=bq9aBvZclxMj/YNbgIdCpOAXL2BapiRv6mu+/9hPz15ZSZsJUwDeOW4WjN4Tk1JRTQ
         NhsMCqiaAx/MHGGCPQWtO7S+o9uDsm/3flniHTaziNVY6sYZk4Elin35EHsvVJHvAbSA
         GI/ChPnLf2fx6+/nxR19A+oQ8xW/Fl+Say0omACtxR9aKDQG+H/WDPg6flWLJWaZGzPg
         sTOwFtnSAAmCfrZMV3tH5Z7NA5dVNgw3hWIBh+9ykEG0C5k7E8o1OmMA82KSpSfSg8Yh
         +vFXa0vQADn53HzwKyliMjjBV6C2y/eAjNQHPLbbz9CA5FW6EiAJ2VRjdbTkRIxbYcNq
         oz2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:arc-authentication-results;
        bh=+/4QNu3bfI+DD/4jZonwNVWqAP26cWn37tJyIJhClo0=;
        b=zZUCTj4KKPt6AJ3VSO12+v1apxL/wTP0W4w//7V5eZ/44StF/fhC585py7kx5MDa0K
         zSxakXb6KMNTx3dAAfpLQNAct52kMXvX+mmXsyvNRud9+5VDiFt8e0uBd0xlhTKJa6+d
         RZ+1cRZNpIEpUn8hqZ6LXbOWhfU5NiV3AXbKO9yzyxmL5Hm22J/dN5O2X39urL+2iBcv
         +/NIB7X4FC7Emm2GsVKgiNbucM3Hgv595CUUO5M8C8EJTMYPOExNdfsY+QCXbvFvYlIr
         WtcYMefBNEOKaHgZ+0yJKawF07xs3NZaR7bbQMnDmFxwXpQFXR4E+e3f+R2nOL/KYfdB
         GKAA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=eH49kfYo;
       spf=pass (google.com: domain of daniel.diaz@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=daniel.diaz@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=eH49kfYo;
       spf=pass (google.com: domain of daniel.diaz@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=daniel.diaz@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
X-Google-Smtp-Source: AH8x226VsL0/3HG13sI1jydFhtj3jqg0FF+iGdRYkIDBJ2SyfJ0HmqQYgSKtT+CJoTeWNKNsP0/5yA==
From: =?UTF-8?q?Daniel=20D=C3=ADaz?= <daniel.diaz@linaro.org>
To: shuahkh@osg.samsung.com,
	linux-kselftest@vger.kernel.org
Cc: Anders Roxell <anders.roxell@linaro.org>,
	=?UTF-8?q?Daniel=20D=C3=ADaz?= <daniel.diaz@linaro.org>,
	Shuah Khan <shuah@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Kate Stewart <kstewart@linuxfoundation.org>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2] selftests: sync: missing CFLAGS while compiling
Date: Tue,  6 Feb 2018 16:23:39 -0600
Message-Id: <1517955821-11511-1-git-send-email-daniel.diaz@linaro.org>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591692060061952233?=
X-GMAIL-MSGID: =?utf-8?q?1591692060061952233?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Anders Roxell <anders.roxell@linaro.org>

Based on patch: https://patchwork.kernel.org/patch/10042045/

arch64-linux-gnu-gcc -c sync.c -o sync/sync.o
sync.c:42:29: fatal error: linux/sync_file.h: No such file or directory
 #include <linux/sync_file.h>
                             ^
CFLAGS is not used during the compile step, so the system instead of
kernel headers are used.  Fix this by adding CFLAGS to the OBJS compile
rule.

Reported-by: Lei Yang <Lei.Yang@windriver.com>
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
Signed-off-by: Daniel Díaz <daniel.diaz@linaro.org>
---
 tools/testing/selftests/sync/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/sync/Makefile b/tools/testing/selftests/sync/Makefile
index b3c8ba3..d0121a8 100644
--- a/tools/testing/selftests/sync/Makefile
+++ b/tools/testing/selftests/sync/Makefile
@@ -30,7 +30,7 @@ $(TEST_CUSTOM_PROGS): $(TESTS) $(OBJS)
 	$(CC) -o $(TEST_CUSTOM_PROGS) $(OBJS) $(TESTS) $(CFLAGS) $(LDFLAGS)
 
 $(OBJS): $(OUTPUT)/%.o: %.c
-	$(CC) -c $^ -o $@
+	$(CC) -c $^ -o $@ $(CFLAGS)
 
 $(TESTS): $(OUTPUT)/%.o: %.c
 	$(CC) -c $^ -o $@
-- 
2.7.4

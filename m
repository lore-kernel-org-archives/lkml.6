Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELt0DHz2U13PQS2hKOGsyO3VbWRaBVWvk2xd+VSy0lgaU30aP4Mk7i763etHwmgA2Saei2Dr
ARC-Seal: i=1; a=rsa-sha256; t=1519411049; cv=none;
        d=google.com; s=arc-20160816;
        b=HBVyp54GEQPk53cmuMJDtGR3isP09DkOWGmwacCuDsUZH8e3fDi1QZw1GWesSZnJpj
         Z/vr9wO0q0wUXvOI+FsIuptgczpi/C869eFDn3eUTiNC2/ZjD9aTvdXUZGoAznEERJRZ
         zodk2DSu9/116BSjC/KUbSbuB98B/AozA2Wsd67eT3CcFsi73TEayk3Jr293uAjclAyh
         Pd0hwX9uN4jgnO/p7Lc9apiy3i45/fZwlCwWH0nfspWrNNvQyduuBr1oEZHOkHzqLEqX
         z7nkEAhg5/rvUuXZ2fOwZ72mGSRqqOHAUMU5EUEznW1F0AdzLR8gfvUkYbJVYFZ3IP6W
         hwag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=T4WhMjlXCaHHlxvHITY9q7PkdHMmJHI+5JlwgU7EcMo=;
        b=AVVHIyfjdyjtJ2kgVzhDQtwid4LO2YXm6u40c7o44MrFBnU9ueUPZpUB+C780yP9wY
         mYIA+J+ULPQda1PtjyXqw9nyDHVbpd0hgDltUBD5kY+FCfPd5wkCu6FSrj9MUhwnifkc
         K8c++y8h7/cX4YC1Wm7BloZbSSH7Is4lbp9Wx2Umq7Bh9U3jwNTN5r24q36emrUlExUy
         I83e6m+g/6jPuOa9Di57aWXtTYQ7nJVodbnB4Yt4GC087/30AkTZoEDghDcUNJhH6kso
         YhtnCtrBfbeazDjcLG2WEI7XDPWK9q6kKrCJRWo9+kcKPlvwwm2dFMXjE27R/FfpaO4s
         RkYA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>,
	Nicholas Bellinger <nab@linux-iscsi.org>
Subject: [PATCH 4.4 102/193] target/user: Fix cast from pointer to phys_addr_t
Date: Fri, 23 Feb 2018 19:25:35 +0100
Message-Id: <20180223170341.943894631@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170325.997716448@linuxfoundation.org>
References: <20180223170325.997716448@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593217960385749010?=
X-GMAIL-MSGID: =?utf-8?q?1593217960385749010?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Arnd Bergmann <arnd@arndb.de>

commit 0633e123465b61a12a262b742bebf2a9945f7964 upstream.

The uio_mem structure has a member that is a phys_addr_t, but can
be a number of other types too. The target core driver attempts
to assign a pointer from vmalloc() to it, by casting it to
phys_addr_t, but that causes a warning when phys_addr_t is longer
than a pointer:

drivers/target/target_core_user.c: In function 'tcmu_configure_device':
drivers/target/target_core_user.c:906:22: error: cast from pointer to integer of different size [-Werror=pointer-to-int-cast]

This adds another cast to uintptr_t to shut up the warning.
A nicer fix might be to have additional fields in uio_mem
for the different purposes, so we can assign a pointer directly.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Nicholas Bellinger <nab@linux-iscsi.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/target/target_core_user.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/target/target_core_user.c
+++ b/drivers/target/target_core_user.c
@@ -900,7 +900,7 @@ static int tcmu_configure_device(struct
 	info->version = __stringify(TCMU_MAILBOX_VERSION);
 
 	info->mem[0].name = "tcm-user command & data buffer";
-	info->mem[0].addr = (phys_addr_t) udev->mb_addr;
+	info->mem[0].addr = (phys_addr_t)(uintptr_t)udev->mb_addr;
 	info->mem[0].size = TCMU_RING_SIZE;
 	info->mem[0].memtype = UIO_MEM_VIRTUAL;
 

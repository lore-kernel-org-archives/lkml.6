Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x2246tChXIuU4qnFaUGkipoSD1fs1omnDi7xr9HKz5zs2lm1PFxSiYOmrbe/H0cx2GPkT69v8
ARC-Seal: i=1; a=rsa-sha256; t=1519410826; cv=none;
        d=google.com; s=arc-20160816;
        b=o0zi2xnzflE7Ej18gTZ8Lw5lV5nHATVa7WnB37hoey4bEjZJ7gC3y4IN7elBhzIqoC
         TJYdPkWvGYe3NthclTPrgYPYEts84ozBSs1Ky/glR4rZQrT5DBup28iYJavXDcwwC2IB
         8tJSgBL0fFW4nsu+wikr/+PaFco08WNVuVZ+MigQNUAHgR0IT9zCObPmDMOHwPiPjHp/
         cv1pZjDiOXQqXtQnDgjPzglpC0yU4hDZox2Gjt+96Px9qDurnftZ9xLPgzfxycKhQMx8
         zbn7scVcyUPMrEQE6j53OCKlsPz2heVt9/U7Cmk9inc70/2V9feA2yquVRiXqTsYXXgZ
         MESw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=7QFJC5CwjK6lNl9ZrG70BTt/kPWp8vmFgySjf4DLX90=;
        b=Kgoi0N9Zq5BNnXTqruaThoMltAr6LNXqs/E1LOgqRXPs9vkAF7lrSwJi0lA4qXo2Jz
         iBu/LjTEYBzJKJ0uw6GQrwkdb/tjqqNfdBld2gbDr0qMU7DnKTUlZZS+wa5be8l4dHR+
         vLOcbt07pTGxBZ4SE85sebxOWAj0zkfEln8EkeVZKfEUV7uZWqpV+/fkDi9R0FlrJR7x
         gxvpqOXOk99mElExYR5RiVZDQSnubqdc9YYYoqvde16OzNG+pn4ep9ixxkQlkezadTe2
         xarTFe4q0aoqTCnUlE/kTu5Ye9eXxJsgwvLqeYTD5Qzjh/9msOS6J2ZREtXdZ3EBs+gA
         gvoA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Ben Hutchings <ben@decadent.org.uk>
Subject: [PATCH 4.4 026/193] staging: android: ashmem: Fix a race condition in pin ioctls
Date: Fri, 23 Feb 2018 19:24:19 +0100
Message-Id: <20180223170330.172960669@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170325.997716448@linuxfoundation.org>
References: <20180223170325.997716448@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593217726489557285?=
X-GMAIL-MSGID: =?utf-8?q?1593217726489557285?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ben Hutchings <ben@decadent.org.uk>

commit ce8a3a9e76d0193e2e8d74a06d275b3c324ca652 upstream.

ashmem_pin_unpin() reads asma->file and asma->size before taking the
ashmem_mutex, so it can race with other operations that modify them.

Build-tested only.

Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/staging/android/ashmem.c |   19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

--- a/drivers/staging/android/ashmem.c
+++ b/drivers/staging/android/ashmem.c
@@ -704,30 +704,32 @@ static int ashmem_pin_unpin(struct ashme
 	size_t pgstart, pgend;
 	int ret = -EINVAL;
 
+	mutex_lock(&ashmem_mutex);
+
 	if (unlikely(!asma->file))
-		return -EINVAL;
+		goto out_unlock;
 
-	if (unlikely(copy_from_user(&pin, p, sizeof(pin))))
-		return -EFAULT;
+	if (unlikely(copy_from_user(&pin, p, sizeof(pin)))) {
+		ret = -EFAULT;
+		goto out_unlock;
+	}
 
 	/* per custom, you can pass zero for len to mean "everything onward" */
 	if (!pin.len)
 		pin.len = PAGE_ALIGN(asma->size) - pin.offset;
 
 	if (unlikely((pin.offset | pin.len) & ~PAGE_MASK))
-		return -EINVAL;
+		goto out_unlock;
 
 	if (unlikely(((__u32)-1) - pin.offset < pin.len))
-		return -EINVAL;
+		goto out_unlock;
 
 	if (unlikely(PAGE_ALIGN(asma->size) < pin.offset + pin.len))
-		return -EINVAL;
+		goto out_unlock;
 
 	pgstart = pin.offset / PAGE_SIZE;
 	pgend = pgstart + (pin.len / PAGE_SIZE) - 1;
 
-	mutex_lock(&ashmem_mutex);
-
 	switch (cmd) {
 	case ASHMEM_PIN:
 		ret = ashmem_pin(asma, pgstart, pgend);
@@ -740,6 +742,7 @@ static int ashmem_pin_unpin(struct ashme
 		break;
 	}
 
+out_unlock:
 	mutex_unlock(&ashmem_mutex);
 
 	return ret;

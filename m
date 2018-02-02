Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x225U0evUXqoPIUnbC4QKs1wqeg9VkG6yz5u2wuW8gC7mr49OXhK9sLFuozB1XbghiQNbpjmw
ARC-Seal: i=1; a=rsa-sha256; t=1517591306; cv=none;
        d=google.com; s=arc-20160816;
        b=t8Z9TlQhWORmhv8mCCX+5/2TQB1OX1KnVNJa+pMPAPFba/q42oFSi5lDyNv8l67aGH
         4xT3gzBYFZ68P5XaOVYMty35hbH5IBVtoWwR78dlRsu/ls7xd6NS0TWrihLSVy8bHlNl
         CRtz+c7P2VTfywi9J2tIC9AK68fcn/FAJiVxeB76VB9imoTYQzLpCkukoSj71EY95qNB
         GqRXuL3/tG3+nhYZlWF1tmYzhjuRSqJXn9Ghcxc0Vwz2YTOrX8L5IxjLEXFZrERpK8dp
         cX0RAuWm+5XRSkbTH9M08fRf/8sxrMK70W8VtxmIEpin0Kfw1Ge8AIGwGChw1RPQG85a
         DRyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=fMlEblNVby3vinrLbHvn52/NPHa6RjVAueED1cPHNWI=;
        b=uwyH7UZOHZE4g44QnOma7Q4tYflBUBhC/HL1nCnsuawxpKIkNtbWYysoVVo156JmOr
         DO0S1u/gSriUyjZaeNdtrlWpWVILd4mHwJUO4GUKTlK/AoFsJZ8aboO73sglmMmD5nYN
         hN4KEwe3wI5tBGFdtqn1CyQpPlxDDbDel7IdeB7rqidd3x/YbqMpvrGa9LUSkjeS1JwN
         ynW4kNxvg+UhHqHZI++a3kkg14azK5746jGhrxpVl2hyn6/kgwofDiAPlbljwUZqFp35
         nQjobhqZ6/R1I4NAwSPmv0cgae7WD/bLLtxgeWtyC/6qZMHM4G+P//sgQj/G6IEzXWOC
         X3OQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 4.14 006/156] gpio: Fix kernel stack leak to userspace
Date: Fri,  2 Feb 2018 17:56:27 +0100
Message-Id: <20180202140840.599129976@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180202140840.242829545@linuxfoundation.org>
References: <20180202140840.242829545@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1591309489818363187?=
X-GMAIL-MSGID: =?utf-8?q?1591309821411125225?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Linus Walleij <linus.walleij@linaro.org>

commit 24bd3efc9d1efb5f756a7c6f807a36ddb6adc671 upstream.

The GPIO event descriptor was leaking kernel stack to
userspace because we don't zero the variable before
use. Ooops. Fix this.

Reported-by: Arnd Bergmann <arnd@arndb.de>
Reviewed-by: Bartosz Golaszewski <brgl@bgdev.pl>
Reviewed-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpio/gpiolib.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -723,6 +723,9 @@ static irqreturn_t lineevent_irq_thread(
 	struct gpioevent_data ge;
 	int ret, level;
 
+	/* Do not leak kernel stack to userspace */
+	memset(&ge, 0, sizeof(ge));
+
 	ge.timestamp = ktime_get_real_ns();
 	level = gpiod_get_value_cansleep(le->desc);
 

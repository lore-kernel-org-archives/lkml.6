Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/Ihx1pcG50CPCqwlM6NoU7xx5lKDF/Pu3pDB9y6/5v30P4ADtswNMbvvK5LczqIJGbGcvF
ARC-Seal: i=1; a=rsa-sha256; t=1524406392; cv=none;
        d=google.com; s=arc-20160816;
        b=ibz9OyqJfD4p7F/zNIafXCISWLSFGeEh/JStYSNuCJhksB7FfacM0e+nhnfylCJ+ly
         l8K26iSEv05slJOgVKTaplycUNaQV+qVZ1WvW65q8//oGZzeRycEC/uQzGO0XomFg3Q6
         LY/lQZgyMiiJphsEFPCImGx1JURBWMNAiXAWnq7isfetAYylA/uosCIydbKpAyUDYp3M
         dO4Bmtv+y3NO5DOtVggDRPbQpYoFaA/i9EU3vOO0J5V2mUBOhyrP7JPQF1Ex6No7eLnV
         d85xzU0qgjtuOhxQi3Xs0ttYLu27G7cJLOdzH+iVHc14pI8pqbapYfdG684UDvPoosvo
         xmMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=SLQ5KUstW/MHwmXpiyvAbpid7TCHx7Qt9WAQkSxms/Q=;
        b=pJJRcssiPBSDhAxTVLDMD2w5aKJKvM6u/ffVYbG8XH83MzXp5nNmLE0N51/KKBsQau
         PDuLl4Vyee49myIPpZfQAfXd8VdZDvwPDX8NdGBWpjKNMTDyoUJxGt5OmWJ/DYiYrikC
         Wkk9G+1gsVn9J5J0XYMa43VGuSWhQsftsRWtSelu7UQ7HXLlrYJtF/6UTZ+aEUwdYz+7
         A4QHhETEGQIIXOgF4dTG1WTsQsvXNu9iFY+IZiXYkexINg8bPH78VOM65A2zC8uDN2Oq
         13+P2cFyXuwDqxo4l6m7J1o6nh6RiKNSciMU/OcC44mdE/WwUTcWMgeZ/wcJqJ2nZ8+N
         aJsA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Andi Kleen <ak@linux.intel.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Stephen Boyd <sboyd@kernel.org>
Subject: [PATCH 4.9 53/95] clk: fix false-positive Wmaybe-uninitialized warning
Date: Sun, 22 Apr 2018 15:53:22 +0200
Message-Id: <20180422135212.582894376@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135210.432103639@linuxfoundation.org>
References: <20180422135210.432103639@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598455168511704983?=
X-GMAIL-MSGID: =?utf-8?q?1598455957719944598?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Arnd Bergmann <arnd@arndb.de>

commit ce33f284935e08229046b30635e6aadcbab02b53 upstream.

When we build this driver with on x86-32, gcc produces a false-positive warning:

drivers/clk/renesas/clk-sh73a0.c: In function 'sh73a0_cpg_clocks_init':
drivers/clk/renesas/clk-sh73a0.c:155:10: error: 'parent_name' may be used uninitialized in this function [-Werror=maybe-uninitialized]
   return clk_register_fixed_factor(NULL, name, parent_name, 0,

We can work around that warning by adding a fake initialization, I tried
and failed to come up with any better workaround. This is currently one
of few remaining warnings for a 4.14.y randconfig build, so it would be
good to also have it backported at least to that version. Older versions
have more randconfig warnings, so we might not care.

I had not noticed this earlier, because one patch in my randconfig test
tree removes the '-ffreestanding' option on x86-32, and that avoids
the warning. The -ffreestanding flag was originally global but moved
into arch/i386 by Andi Kleen in commit 6edfba1b33c7 ("[PATCH] x86_64:
Don't define string functions to builtin") as a 'temporary workaround'.

Like many temporary hacks, this turned out to be rather long-lived, from
all I can tell we still need a simple fix to asm/string_32.h before it
can be removed, but I'm not sure about how to best do that.

Cc: stable@vger.kernel.org
Cc: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/clk/renesas/clk-sh73a0.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/drivers/clk/renesas/clk-sh73a0.c
+++ b/drivers/clk/renesas/clk-sh73a0.c
@@ -46,7 +46,7 @@ struct div4_clk {
 	unsigned int shift;
 };
 
-static struct div4_clk div4_clks[] = {
+static const struct div4_clk div4_clks[] = {
 	{ "zg", "pll0", CPG_FRQCRA, 16 },
 	{ "m3", "pll1", CPG_FRQCRA, 12 },
 	{ "b",  "pll1", CPG_FRQCRA,  8 },
@@ -79,7 +79,7 @@ sh73a0_cpg_register_clock(struct device_
 {
 	const struct clk_div_table *table = NULL;
 	unsigned int shift, reg, width;
-	const char *parent_name;
+	const char *parent_name = NULL;
 	unsigned int mult = 1;
 	unsigned int div = 1;
 
@@ -135,7 +135,7 @@ sh73a0_cpg_register_clock(struct device_
 		shift = 24;
 		width = 5;
 	} else {
-		struct div4_clk *c;
+		const struct div4_clk *c;
 
 		for (c = div4_clks; c->name; c++) {
 			if (!strcmp(name, c->name)) {

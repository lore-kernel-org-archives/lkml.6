Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x225Etn3giIWJFMkBjsQMZUuAO+C9AxYG/8WlKqSTa85C4G6ge/IKqfhFEoA+Z4Iso02rc5Lq
ARC-Seal: i=1; a=rsa-sha256; t=1519411080; cv=none;
        d=google.com; s=arc-20160816;
        b=d7w3wbsvHImy8CRf9HP7NEZmJZeshWMrSchGoFZeh4x4rdC7QMkyjjPDmeQ/TfaFTO
         PG5zvxg7d7j3w//qr+Rv2JNtLwY7qmpy9z6LeV2lBCm4BRAmUuKnZDThDzSAX++VOvId
         Q8yaq0Jz4S4fYwNakgLOR1f6lyv9l5MjTgH6BffMFvVWIk0sEO6bf1oFV4+HCxPQks/Q
         l0FvUZvWKtbwZTBGVhoHZ3G8jD2Jj3qHOjePefCHJzPsJFlY7uwJq4URTwcPohG5Lfye
         5/1r72QSlodndqvGN2g8kp6WidOVQZA5DnLXZF7Gwswu3xfb9KR8bJmHxLFE1fJHrDQZ
         kOLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=Sf8IFVnsiinYnRs4/m1xXgTMXhpOMiXtPAcGrgXl8fU=;
        b=x2DqtDt9jFZcQvyqb20VKhWdW0F6MJoJSC0ZmL6h9rxDdx22io8daMgdiydaTy3/tu
         pNesJwosTAx0YLf/t7iu4rycQkaQgd/BoLjI48f2GAWTGm9H3hOqqgMzlbTSsf6GoHfa
         ZKcQ5Es51ac3NJTYU6Mte181ACbD0WrPbV50ibITTAzIUKzHDN4JB2pgNFAmZcDST8sD
         /ZzGDADbXiGWcJaYG+jnGr88sv2LwDb/piDGdWe4OsH4LVbdpf0cwAVKaH/2DzXNP5Rz
         hrodML54ddNgJQ/oOBBFbRdRXYV2Wd8PiDohgqm8kvdt7dWGBPd1Ykv9kSQSjmzc+dfI
         yWig==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>,
	Krzysztof Kozlowski <k.kozlowski@samsung.com>,
	Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH 4.4 112/193] hwrng: exynos - use __maybe_unused to hide pm functions
Date: Fri, 23 Feb 2018 19:25:45 +0100
Message-Id: <20180223170343.450919460@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170325.997716448@linuxfoundation.org>
References: <20180223170325.997716448@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593217993183363171?=
X-GMAIL-MSGID: =?utf-8?q?1593217993183363171?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Arnd Bergmann <arnd@arndb.de>

commit b93f342da1766ef1740e6277508329356c4ea48b upstream.

The exynos random driver uses #ifdef to check for CONFIG_PM, but
then uses SIMPLE_DEV_PM_OPS, which leaves the references out when
CONFIG_PM_SLEEP is not defined, so we get a warning with
PM=y && PM_SLEEP=n:

drivers/char/hw_random/exynos-rng.c:166:12: error: 'exynos_rng_suspend' defined but not used [-Werror=unused-function]
drivers/char/hw_random/exynos-rng.c:171:12: error: 'exynos_rng_resume' defined but not used [-Werror=unused-function]

This removes the incorrect #ifdef and instead uses a __maybe_unused
annotation to let the compiler know it can silently drop
the function definition.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/char/hw_random/exynos-rng.c |   10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

--- a/drivers/char/hw_random/exynos-rng.c
+++ b/drivers/char/hw_random/exynos-rng.c
@@ -155,8 +155,7 @@ static int exynos_rng_probe(struct platf
 	return ret;
 }
 
-#ifdef CONFIG_PM
-static int exynos_rng_runtime_suspend(struct device *dev)
+static int __maybe_unused exynos_rng_runtime_suspend(struct device *dev)
 {
 	struct platform_device *pdev = to_platform_device(dev);
 	struct exynos_rng *exynos_rng = platform_get_drvdata(pdev);
@@ -166,7 +165,7 @@ static int exynos_rng_runtime_suspend(st
 	return 0;
 }
 
-static int exynos_rng_runtime_resume(struct device *dev)
+static int __maybe_unused exynos_rng_runtime_resume(struct device *dev)
 {
 	struct platform_device *pdev = to_platform_device(dev);
 	struct exynos_rng *exynos_rng = platform_get_drvdata(pdev);
@@ -174,12 +173,12 @@ static int exynos_rng_runtime_resume(str
 	return clk_prepare_enable(exynos_rng->clk);
 }
 
-static int exynos_rng_suspend(struct device *dev)
+static int __maybe_unused exynos_rng_suspend(struct device *dev)
 {
 	return pm_runtime_force_suspend(dev);
 }
 
-static int exynos_rng_resume(struct device *dev)
+static int __maybe_unused exynos_rng_resume(struct device *dev)
 {
 	struct platform_device *pdev = to_platform_device(dev);
 	struct exynos_rng *exynos_rng = platform_get_drvdata(pdev);
@@ -191,7 +190,6 @@ static int exynos_rng_resume(struct devi
 
 	return exynos_rng_configure(exynos_rng);
 }
-#endif
 
 static const struct dev_pm_ops exynos_rng_pm_ops = {
 	SET_SYSTEM_SLEEP_PM_OPS(exynos_rng_suspend, exynos_rng_resume)

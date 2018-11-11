Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E101C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 02:48:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E58FE20989
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 02:48:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="BaAot2+q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E58FE20989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727403AbeKKMf7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 11 Nov 2018 07:35:59 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:41311 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727112AbeKKMf7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Nov 2018 07:35:59 -0500
Received: by mail-qk1-f196.google.com with SMTP id 189so8169730qkj.8
        for <linux-kernel@vger.kernel.org>; Sat, 10 Nov 2018 18:48:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:from:to:cc:mime-version:content-transfer-encoding
         :references:date:subject:in-reply-to;
        bh=ieUj7dC9LNUl53/E8eb1Cskozd0JqFmxwyec8tEE9j4=;
        b=BaAot2+qDgH73Jyum4WxKSxq4c0tkkOWbKehGcSeAJ3Q6pRjPXcExeBfaK08nV7a3n
         gKAvXNF6oETMAMvmsiaRHPJGMwG8BHJmw63PLrBN90ZxLLaYmMfnSyh3sK+7jT4FgHTK
         nz8vz/DvvIqr6laSsD8X6EkXc/Bs0erf7wzr8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:to:cc:mime-version
         :content-transfer-encoding:references:date:subject:in-reply-to;
        bh=ieUj7dC9LNUl53/E8eb1Cskozd0JqFmxwyec8tEE9j4=;
        b=n15tShb81eb87Kxkwa0xm44RlSF47XoScNs4i7ZurPGpPJgGHAAG1q1MSX76c6vXLq
         /Loe92oxyYU3S7YQMvz7D7GP+D8s+1w0UAohHJLCAvnuPE1OJUROfRaq0fwLqOObsZ/H
         KLZ6Bwo0OcsRKAAEEX0GGXQFsS6ngh8mUjljGNZYUVc/AxvIFQ7HeM41BCSmc69+30RZ
         7UZeLRHNfnY5HUI/h5HVNsQ7NvH9oNMFuZoot9EYtbfNkaJiZc81zzRaTaULhN9GqWdh
         RRtvrwZ2xfiBFnOTAr7llTd6Q1rRBdIMa9mhJjDrogV3oAnI8wEZUEe41KrTgzWv8/X7
         MMsg==
X-Gm-Message-State: AGRZ1gJAMPE47LOZ9lDt85Cz5ozkMeAcJIi5VVnwR6q+kJ5sVN1wNnrV
        vwwm/iHV6mOMMaXP2qrbWzrqSw==
X-Google-Smtp-Source: AJdET5fqopyY+q5LO5aRRgy89z2qDdw+PfVNtCBrno/eLGSxx0zmRTjnjLu/RZCXR9wKJ7w3usBJXg==
X-Received: by 2002:ac8:1ab8:: with SMTP id x53mr14200346qtj.44.1541904530416;
        Sat, 10 Nov 2018 18:48:50 -0800 (PST)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id h25-v6sm10242935qtc.44.2018.11.10.18.48.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 10 Nov 2018 18:48:49 -0800 (PST)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailauth.nyi.internal (Postfix) with ESMTP id 1DEA821E49;
        Sat, 10 Nov 2018 21:48:48 -0500 (EST)
Received: from web3 ([10.202.2.213])
  by compute1.internal (MEProxy); Sat, 10 Nov 2018 21:48:48 -0500
X-ME-Sender: <xms:j5jnW01EW8yh0YmDZomzMeUyw9Q8FNyjrlziQjLvJS04bVV5MqP9CA>
X-ME-Proxy: <xmx:j5jnWwzG_c4oAinJnxF6460Pvg_D4RES488MNXrtiPH4s_CKrUnQ4g>
    <xmx:j5jnW7rb-Gqt4whCZBSbuf_OPLeAawlg5J5r10ycZ5EV3qT9OvqZkg>
    <xmx:j5jnW8rRxiOsWp1fBShn3ymAQTFUAPeLGmlT-0SmJObkvD5iTAoi4g>
    <xmx:j5jnW0gMx4su1IKHWEtHqw1H7NaEvL8Uy4Z29RMaEohWoDT6xZ_O3w>
    <xmx:j5jnW1yBpvnGvGvKuYPAIEOuIjVUqPHDDL5zVblwzoX2m2prutUjoA>
    <xmx:kJjnWw7M5J0kGq0XdAXvTw_eycCFDnMdh5P8jYnibRCYwM4uzu_x-c4GesCy-N0c>
Received: by mailuser.nyi.internal (Postfix, from userid 99)
        id 9623F9E53B; Sat, 10 Nov 2018 21:48:47 -0500 (EST)
Message-Id: <1541904527.857883.1572718104.2AE8D0DA@webmail.messagingengine.com>
From:   Rafael David Tinoco <rafael.tinoco@linaro.org>
To:     Alexey Dobriyan <adobriyan@gmail.com>, akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, gorcunov@gmail.com,
        linux-kselftest@vger.kernel.org, shuah@kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Mailer: MessagingEngine.com Webmail Interface - ajax-c0552f07
References: <20181110184920.GA18252@avx2>
Date:   Sun, 11 Nov 2018 00:48:47 -0200
Subject: Re: [PATCH] proc: fixup map_files test on arm
In-Reply-To: <20181110184920.GA18252@avx2>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Including Shuah and kselftest list...

On Sat, Nov 10, 2018, at 4:49 PM, Alexey Dobriyan wrote:
> https://bugs.linaro.org/show_bug.cgi?id=3782
> 
> Turns out arm doesn't allow to map address 0, so try minimum virtual
> address instead.
> 
> Reported-by: Rafael David Tinoco <rafael.tinoco@linaro.org>
> Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
> ---
> 
>  tools/testing/selftests/proc/proc-self-map-files-002.c |    9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> --- a/tools/testing/selftests/proc/proc-self-map-files-002.c
> +++ b/tools/testing/selftests/proc/proc-self-map-files-002.c
> @@ -13,7 +13,7 @@
>   * ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT 
> OF
>   * OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
>   */
> -/* Test readlink /proc/self/map_files/... with address 0. */
> +/* Test readlink /proc/self/map_files/... with minimum address. */
>  #include <errno.h>
>  #include <sys/types.h>
>  #include <sys/stat.h>
> @@ -47,6 +47,11 @@ static void fail(const char *fmt, unsigned long a, 
> unsigned long b)
>  int main(void)
>  {
>  	const unsigned int PAGE_SIZE = sysconf(_SC_PAGESIZE);
> +#ifdef __arm__
> +	unsigned long va = 2 * PAGE_SIZE;
> +#else
> +	unsigned long va = 0;
> +#endif
>  	void *p;
>  	int fd;
>  	unsigned long a, b;
> @@ -55,7 +60,7 @@ int main(void)
>  	if (fd == -1)
>  		return 1;
>  
> -	p = mmap(NULL, PAGE_SIZE, PROT_NONE, MAP_PRIVATE|MAP_FILE|MAP_FIXED, fd, 0);
> +	p = mmap(va, PAGE_SIZE, PROT_NONE, MAP_PRIVATE|MAP_FILE|MAP_FIXED, fd, 0);
>  	if (p == MAP_FAILED) {
>  		if (errno == EPERM)
>  			return 2;

I have sent a patch removing proc-self-map-files-002 AND making 001 to use as a
HINT for mmap (MAP_FIXED) *at least*  *(2 * PAGE_SIZE), which would, likely,
attend all  architectures, avoiding trying to make the test specific to one,
and, still, test the symlinks for issues (like bad chars, spaces, so on).

Both tests (001 and 002) have pretty much the same code, while they could have 2
tests in a single code, using kselftest framework. Is NULL hint + MAP_FIXED
something imperative for this test ? Why not to have all in a single test ? Are
you keeping the NULL hint just to test mmap, apart" from the core of this test ?

Sorry to insist.. If you want to keep it like this, I can create a similar test
in LTP - for the symlinks only, which seem important - and blacklist this one in
our function tests kselftest list (https://lkft.linaro.org/), then no change is
needed on your side.

Thanks 

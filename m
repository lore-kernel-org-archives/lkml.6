Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AG47ELueRjmDYJwvWiE1PJJS1WRf+AWeSVLprfAjRBgqKvx7uTaWsTVp+Y3X/XDuUfBJp+vdbi7u
ARC-Seal: i=1; a=rsa-sha256; t=1522075455; cv=none;
        d=google.com; s=arc-20160816;
        b=VWoLFJKKcLdi4Ua7qhrhS4kJGlQLvkCTAmdvT931iK0lX/flJyxpdrEhFJUj/skB8h
         wHjnhO47qiNu5WTGG+tZ6EWj6t5TWWuvo5lCs4tRSDtZ93DzkhMwuLgiC7qspp0iI7YI
         aMoAJUFSe3/qwnHuvYrE7VvV6N77H8j8DoSTqS46ACxfJ776vNqqmrfQA4h6F0dPsGfz
         t89QVIZgp+BAFrje+8KxT92wxNZYmVGc6E3EVUNROthVcYqfHoYl6bGaWoKfw2adSr9E
         RjNyYbvCRktSjGp5z6PHLA3Y7oG3YFD8/986bGj90CCLZuJ3UrP+LsMu6mnAhqkYo0k+
         vs1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:content-transfer-encoding
         :content-language:in-reply-to:mime-version:user-agent:date
         :message-id:from:references:cc:to:subject:arc-authentication-results;
        bh=YAUtPWld5+NGx6Fhf39hFYfVwVKRHIeK4CqNVxo9jZ8=;
        b=Xi66ht0/QcMuVjhIpFff/nmRMir3KNsE2B4DBRvTuHZ4p30lb1s2hp3hgHWz9+SuIM
         YiH4X46jO5OCsIoEohTQhuw4UFAKX3L/g3q1SNVnkaclXC4+Gt9jrLb54EN9Tw6gM/3k
         j+BW+UQ3MmEOT+QYX6Ge+gArXd0CdvDkCUZWRfGzVArnpvXzr2euNwY6MFiQYfTNZqPj
         uORK5vNstgdQ2zuXnmSiz3xo9CA6gMgAZo27bMTfB+q/hNothfPjP9PK4pa7eZpQaFrO
         liGChbAk9A/X5MA/I5zX664s4egG/Cg+fciYwjMHM5eIY0ZBqenDvbCHZfdJaM2GOtvy
         EvzQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=samsung.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=samsung.com
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752186AbeCZOoP (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Mon, 26 Mar 2018 10:44:15 -0400
Received: from osg.samsung.com ([64.30.133.232]:48109 "EHLO osg.samsung.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751926AbeCZOoO (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 26 Mar 2018 10:44:14 -0400
Subject: Re: [PATCH] selftests: Print the test we're running to /dev/kmsg
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Shuah Khan <shuahkh@osg.samsung.com>,
        Shuah Khan <shuah@kernel.org>
References: <20180323094427.21938-1-mpe@ellerman.id.au>
From: Shuah Khan <shuahkh@osg.samsung.com>
Message-ID: <5575d84d-5737-9610-5cef-bbfda909b704@osg.samsung.com>
Date: Mon, 26 Mar 2018 08:44:04 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180323094427.21938-1-mpe@ellerman.id.au>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
X-Mailing-List: linux-kselftest@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595721182279802309?=
X-GMAIL-MSGID: =?utf-8?q?1596011793223044784?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 03/23/2018 03:44 AM, Michael Ellerman wrote:
> Some tests cause the kernel to print things to the kernel log
> buffer (ie. printk), in particular oops and warnings etc. However when
> running all the tests in succession it's not always obvious which
> test(s) caused the kernel to print something.
> 
> We can narrow it down by printing which test directory we're running
> in to /dev/kmsg, if it's writable.
> 
> Example output:
> 
>   [  170.149149] kselftest: Running tests in powerpc
>   [  305.300132] kworker/dying (71) used greatest stack depth: 7776 bytes left
>   [  808.915456] kselftest: Running tests in pstore
> 
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> ---
>  tools/testing/selftests/Makefile | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
> index 7442dfb73b7f..0fbe778efd5f 100644
> --- a/tools/testing/selftests/Makefile
> +++ b/tools/testing/selftests/Makefile
> @@ -130,6 +130,7 @@ ifdef INSTALL_PATH
>  		BUILD_TARGET=$$BUILD/$$TARGET;	\
>  		echo "echo ; echo Running tests in $$TARGET" >> $(ALL_SCRIPT); \
>  		echo "echo ========================================" >> $(ALL_SCRIPT); \
> +		echo "[ -w /dev/kmsg ] && echo \"kselftest: Running tests in $$TARGET\" >> /dev/kmsg" >> $(ALL_SCRIPT); \
>  		echo "cd $$TARGET" >> $(ALL_SCRIPT); \
>  		make -s --no-print-directory OUTPUT=$$BUILD_TARGET -C $$TARGET emit_tests >> $(ALL_SCRIPT); \
>  		echo "cd \$$ROOT" >> $(ALL_SCRIPT); \
> 

Thanks Michael. I will get this to 4.17-rc1

-- Shuah

Return-Path: <mpe@ellerman.id.au>
X-Google-Smtp-Source: AIpwx4/bdHPxCCriS//vcGwPu+pEl9cpdbj0vDWy8jFjy2xICTZ4Wa7F+ErqtW/p7ux2n6tE4EWF
ARC-Seal: i=1; a=rsa-sha256; t=1523341250; cv=none;
        d=google.com; s=arc-20160816;
        b=EbZSbRi6UA7Pf/lCeR6yYgbf6vbvOxpK6woa8ZUSaawCfh2+UY0w6/+cNfbKGFausQ
         ZSDv4aTwdW/pFWyt7tlHtEgbnJUfABhBfZJnNReJSbaVunUB7LG8+Az3K1BQYY7RZ1Hs
         jhTvuaNKBZ8+/jzwgok8SFA96dsRpDCYyB68WBcDkZeroxKdDJZ1oK2lCRHCoiNVqeT0
         y5vLiwxb7+FEnppV2TRQibXYQy81lcTTfRRAHBwu2R4UKU3URb28mjce3Uk9+IK8d+3e
         qvUzqQL0XkpMR5NOXVwbrXXGfmI/2plnWKyVMr1vPb/1Pn9O7ciZUlcWKeM+Oi1zUjPo
         UrFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:arc-authentication-results;
        bh=1E8opJIdi9bymGnt5TmReo/2GPiT3ypbjRRoJY9PagA=;
        b=YXb9h2QocCDb1iPIm0Wg2vDK1SRceO0SHKDldHIClQRfcNkM3xoPS1+viAKUn6Rez9
         7GLXVHE3FXAENohylIDjDJaCOzCdqFRqW+hafYkuVCPW8ybHTEu8+i5wfgUpFMZIuGeR
         wZAnfDM0hUlajYEjdGMC7EPWlnW9sakmvSKggo0Y5g2QGso+dd+NyViV6mLUOJqNzvln
         /ZAZyl8WZFGmvMTsq+R6DaSkfaClUGaeqcDX/edrTjFNw1lTIGJre3UEo2EP/BQ/abdW
         V0/fna4y2lFMVgjQ5NKVaUTLvqj717FsnagmKFGk2xx+ncEASdlL/8MuF85b5rhr1wsS
         LeBQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 203.11.71.1 is neither permitted nor denied by best guess record for domain of mpe@ellerman.id.au) smtp.mailfrom=mpe@ellerman.id.au
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 203.11.71.1 is neither permitted nor denied by best guess record for domain of mpe@ellerman.id.au) smtp.mailfrom=mpe@ellerman.id.au
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
From: Michael Ellerman <mpe@ellerman.id.au>
To: Christian Brauner <christian.brauner@ubuntu.com>, viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org, ebiederm@xmission.com, torvalds@linux-foundation.org, gregkh@linuxfoundation.org
Cc: containers@lists.linux-foundation.org, Christian Brauner <christian.brauner@ubuntu.com>
Subject: Re: [PATCH 4/4 v5 RESEND] selftests: add devpts selftests
In-Reply-To: <20180313165527.24038-5-christian.brauner@ubuntu.com>
References: <20180313165527.24038-1-christian.brauner@ubuntu.com> <20180313165527.24038-5-christian.brauner@ubuntu.com>
Date: Tue, 10 Apr 2018 16:20:44 +1000
Message-ID: <87efjnbn0j.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594842300602680139?=
X-GMAIL-MSGID: =?utf-8?q?1597339074547178410?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Christian,

Christian Brauner <christian.brauner@ubuntu.com> writes:
> diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
> index 7442dfb73b7f..dbda89c9d9b9 100644
> --- a/tools/testing/selftests/Makefile
> +++ b/tools/testing/selftests/Makefile
> @@ -7,6 +7,7 @@ TARGETS += cpufreq
>  TARGETS += cpu-hotplug
>  TARGETS += efivarfs
>  TARGETS += exec
> +TARGETS += filesystems
   ^ This, and ...

> diff --git a/tools/testing/selftests/filesystems/Makefile b/tools/testing/selftests/filesystems/Makefile
> index 13a73bf725b5..4e6d09fb166f 100644
> --- a/tools/testing/selftests/filesystems/Makefile
> +++ b/tools/testing/selftests/filesystems/Makefile
> @@ -1,5 +1,5 @@
>  # SPDX-License-Identifier: GPL-2.0
> -TEST_PROGS := dnotify_test
> +TEST_PROGS := dnotify_test devpts_pts
                 ^
                 this ...

Have the unfortunate effect of running dnotify_test as part of the
default selftest run.

dnotify_test boils down to:

	while (1) {
		pause();
		printf("Got event on fd=%d\n", event_fd);
	}


ie. an infinite loop :)

I'll send a patch to fix it.

cheers

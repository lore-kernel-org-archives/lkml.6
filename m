Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 429CDC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 16:21:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0A8020651
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 16:21:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="CRulOkx8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405399AbfAPQVc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 11:21:32 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:38214 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405384AbfAPQVa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 11:21:30 -0500
Received: by mail-pl1-f196.google.com with SMTP id e5so3235049plb.5
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jan 2019 08:21:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:user-agent:in-reply-to:references:mime-version
         :content-transfer-encoding:subject:to:cc:from:message-id;
        bh=ZHvEOX0piLyA//gNLTgPMgZxvpVqJnl1Jlfuc8JWdCU=;
        b=CRulOkx8s/KsV2vJSEbTHqF1eatzggxEQlgynXea9ITnoCfJH5y1fQV/BlDYF+esoI
         hlzjofRg/MEPvc5VIRPEbwy5G/0KTgwFHfEfCZPpsoygKLai5enyKo+gflwzmftPXrsX
         Wf0uIGmRhd3ZAoCqqr/8jbDQPiXgDjKV9QSIuY/Hl0/vkibkeOXfdF/3fvqzU+CYQa9r
         fq7WtL4BwsS/9eg2bagXnsJefTE1x4kQCC5LaoVwenFILt0VRHTlJFcfrqJiqiLg/vbL
         TMH4XoY838bqVMW4teFgO9eNUqOzZIlI4Xj466GqTxClF03iySBHitix9M1+EvNe2IVg
         XQmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:user-agent:in-reply-to:references
         :mime-version:content-transfer-encoding:subject:to:cc:from
         :message-id;
        bh=ZHvEOX0piLyA//gNLTgPMgZxvpVqJnl1Jlfuc8JWdCU=;
        b=GQDqLAKMqMjOdzj5LARSkjf0hf2rJTDbUJ7orWvjzEsL1RBnVc1vR18LdWDjfV+jpl
         MFaE0DZzYfjZWKFVYIsvDi8MGWWlsBidrplZY0Gxb5AQfWPqjgAVoi+/nurIGkIrBC2n
         ba2i8CaI2OhAklPbW7zDEcTJPjz/cOANCXh/zRihGKG82rYIdJuEbW2rJam3XRqo/4S2
         EFFKRwMUD1pYtoISpdXY3MSYDbQeriCbmAs6dFPHQ1E1XhT+f9MeVgVbjBpz73SwYuih
         kmF46rimDEYdTKtfM2sNSyDmKdPp/yNvZf8uAJoUDxc73r3gJy28PglM2MhW54u/9gjB
         q7yA==
X-Gm-Message-State: AJcUukfDAVzSG+mhJR4iLiyc1XZVZzpwSigsEf+CaabI+nduiydfhQWD
        g/2pB0FAVMSfKOr0tTjdY2WzFA==
X-Google-Smtp-Source: ALg8bN4KmY2IaYUuLyHOdW4PidLpUheOGIdj92rPqNm8Nng/AMEW35tD73bV0ZKFED+4mx1IHp15bg==
X-Received: by 2002:a17:902:9a04:: with SMTP id v4mr10819482plp.34.1547655689334;
        Wed, 16 Jan 2019 08:21:29 -0800 (PST)
Received: from [25.170.158.113] ([172.56.31.87])
        by smtp.gmail.com with ESMTPSA id o1sm8613617pgn.63.2019.01.16.08.21.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Jan 2019 08:21:28 -0800 (PST)
Date:   Wed, 16 Jan 2019 18:21:12 +0200
User-Agent: K-9 Mail for Android
In-Reply-To: <20190116155450.GA3508@kroah.com>
References: <20190116131903.8515-1-christian@brauner.io> <20190116155450.GA3508@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] selftests: add binderfs selftests
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     tkjos@android.com, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, joel@joelfernandes.org,
        arve@android.com, maco@android.com, tkjos@google.com
From:   Christian Brauner <christian@brauner.io>
Message-ID: <EB0D154D-A8CD-4CDB-B66F-C20945722AE2@brauner.io>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On January 16, 2019 5:54:50 PM GMT+02:00, Greg KH <gregkh@linuxfoundation=
=2Eorg> wrote:
>On Wed, Jan 16, 2019 at 02:19:03PM +0100, Christian Brauner wrote:
>> This adds the promised selftest for binderfs=2E It will verify the
>following
>> things:
>> - binderfs mounting works
>> - binder device allocation works
>> - performing a binder ioctl() request through a binderfs device works
>> - binder device removal works
>> - binder-control removal fails
>> - binderfs unmounting works
>>=20
>> Cc: Todd Kjos <tkjos@google=2Ecom>
>> Signed-off-by: Christian Brauner <christian=2Ebrauner@ubuntu=2Ecom>
>> ---
>>  tools/testing/selftests/Makefile              |   1 +
>>  =2E=2E=2E/selftests/filesystems/binderfs/=2Egitignore |   1 +
>>  =2E=2E=2E/selftests/filesystems/binderfs/Makefile   |   6 +
>>  =2E=2E=2E/filesystems/binderfs/binderfs_test=2Ec      | 120
>++++++++++++++++++
>>  =2E=2E=2E/selftests/filesystems/binderfs/config     |   3 +
>>  5 files changed, 131 insertions(+)
>>  create mode 100644
>tools/testing/selftests/filesystems/binderfs/=2Egitignore
>>  create mode 100644
>tools/testing/selftests/filesystems/binderfs/Makefile
>>  create mode 100644
>tools/testing/selftests/filesystems/binderfs/binderfs_test=2Ec
>>  create mode 100644
>tools/testing/selftests/filesystems/binderfs/config
>>=20
>> diff --git a/tools/testing/selftests/Makefile
>b/tools/testing/selftests/Makefile
>> index 1a2bd15c5b6e=2E=2E400ee81a3043 100644
>> --- a/tools/testing/selftests/Makefile
>> +++ b/tools/testing/selftests/Makefile
>> @@ -10,6 +10,7 @@ TARGETS +=3D drivers/dma-buf
>>  TARGETS +=3D efivarfs
>>  TARGETS +=3D exec
>>  TARGETS +=3D filesystems
>> +TARGETS +=3D filesystems/binderfs
>>  TARGETS +=3D firmware
>>  TARGETS +=3D ftrace
>>  TARGETS +=3D futex
>> diff --git a/tools/testing/selftests/filesystems/binderfs/=2Egitignore
>b/tools/testing/selftests/filesystems/binderfs/=2Egitignore
>> new file mode 100644
>> index 000000000000=2E=2E8a5d9bf63dd4
>> --- /dev/null
>> +++ b/tools/testing/selftests/filesystems/binderfs/=2Egitignore
>> @@ -0,0 +1 @@
>> +binderfs_test
>> diff --git a/tools/testing/selftests/filesystems/binderfs/Makefile
>b/tools/testing/selftests/filesystems/binderfs/Makefile
>> new file mode 100644
>> index 000000000000=2E=2E58cb659b56b4
>> --- /dev/null
>> +++ b/tools/testing/selftests/filesystems/binderfs/Makefile
>> @@ -0,0 +1,6 @@
>> +# SPDX-License-Identifier: GPL-2=2E0
>> +
>> +CFLAGS +=3D -I=2E=2E/=2E=2E/=2E=2E/=2E=2E/=2E=2E/usr/include/
>> +TEST_GEN_PROGS :=3D binderfs_test
>> +
>> +include =2E=2E/=2E=2E/lib=2Emk
>> diff --git
>a/tools/testing/selftests/filesystems/binderfs/binderfs_test=2Ec
>b/tools/testing/selftests/filesystems/binderfs/binderfs_test=2Ec
>> new file mode 100644
>> index 000000000000=2E=2Eca4d9b616e84
>> --- /dev/null
>> +++ b/tools/testing/selftests/filesystems/binderfs/binderfs_test=2Ec
>> @@ -0,0 +1,120 @@
>> +// SPDX-License-Identifier: GPL-2=2E0
>> +
>> +#define _GNU_SOURCE
>> +#include <errno=2Eh>
>> +#include <fcntl=2Eh>
>> +#include <sched=2Eh>
>> +#include <stdio=2Eh>
>> +#include <stdlib=2Eh>
>> +#include <string=2Eh>
>> +#include <sys/ioctl=2Eh>
>> +#include <sys/mount=2Eh>
>> +#include <sys/stat=2Eh>
>> +#include <sys/types=2Eh>
>> +#include <unistd=2Eh>
>> +#include <linux/android/binder=2Eh>
>> +#include <linux/android/binderfs=2Eh>
>> +#include "=2E=2E/=2E=2E/kselftest=2Eh"
>> +
>> +int main(int argc, char *argv[])
>> +{
>> +	int fd, ret, saved_errno;
>> +	size_t len;
>> +	struct binderfs_device device =3D { 0 };
>> +	struct binder_version version =3D { 0 };
>> +
>> +	ret =3D unshare(CLONE_NEWNS);
>> +	if (ret < 0)
>> +		ksft_exit_fail_msg("%s - Failed to unshare mount namespace\n",
>> +				   strerror(errno));
>> +
>> +	ret =3D mount(NULL, "/", NULL, MS_REC | MS_PRIVATE, 0);
>> +	if (ret < 0)
>> +		ksft_exit_fail_msg("%s - Failed to mount / as private\n",
>> +				   strerror(errno));
>> +
>> +	ret =3D mkdir("/dev/binderfs", 0755);
>> +	if (ret < 0 && errno !=3D EEXIST)
>> +		ksft_exit_fail_msg(
>> +			"%s - Failed to create binderfs mountpoint\n",
>> +			strerror(errno));
>> +
>> +	ret =3D mount(NULL, "/dev/binderfs", "binder", 0, 0);
>> +	if (ret < 0)
>> +		ksft_exit_fail_msg("%s - Failed to mount binderfs\n",
>> +				   strerror(errno));
>
>Can you check first to see if the kernel under test really even has
>binderfs in it?  If not, you need to just

Hm, I thought that's what the "config" file was for?
E=2Eg=2E a conditional compile or is this just a hint to the
user what's needed to run the test?

Thanks!
Christian

Christian

 abort the test, not fail it,
>so as to allow newer versions of kselftests to run on older kernels=2E
>
>thanks,
>
>greg k-h


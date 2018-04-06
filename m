Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AIpwx48cCCzvdbx65uEs8h/7773X2ttxU4k1LLq/q0qw5R2RGe6fhiDxqeQU6pB9aOG143WRqs7V
ARC-Seal: i=1; a=rsa-sha256; t=1523036524; cv=none;
        d=google.com; s=arc-20160816;
        b=euBayBiHXAjQdl5LUbaXjH13v3foUWAK1MD0is0N3XvZ0O/8XRUYduolUlZRpRgx8Q
         CLDK//7CPG4V97v05lYpH0+lD9ljHCLJhkj79DeBOLEN+63ik2qLm83IXK6P1vdNhIMc
         yjHeVp2Ru/Nam98qX7f7eTkwGydh6qEt1YwdEZRJVVRlwov+XNc+PLCNwlUb6pWozYgb
         oloa6bkG93IA4Fh4YqZG/LCVwZMNTERzCIEC65AenkMvcxDtvSLKU1vWy1+xiPYt879E
         yzPjDz4HIKBkQWmaOGJjku+D14rgJaZfQt6METnf10hAji9hL556mEeHq7QLa7lLjHDb
         /JxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:content-transfer-encoding:cc:to:subject
         :message-id:date:from:references:in-reply-to:mime-version
         :dkim-signature:arc-authentication-results;
        bh=B22MEcnqGsJ213hheWuEdFkGeIvgOgLPkzu0dc1xsvg=;
        b=S6btPShzt7IjLNHn2R1qbh5AdvvARzq60WlWNrU6SEedlGY8ajI/ePgH8HWuButgkQ
         ZLbdOATgwGTlz/gEe8IpkfHsKQTyQdm40Jduk3k0IlxrdaiI11EgFgS9/67fOUGLjC1o
         UiuWmwzZ/axkLwEIqZW4O2shsE7t8aPNZqW6ETkbhWAcMZcI2g1ekpR+zlNKqghbOhOk
         lW8yI6DFItTkxdp8ApWvibEZZksrsNd6IdejjakKqHYVwsG958wDST3pSW1mvtxQE6ps
         tAkuqSYXK29rP5d3i5sj89VPEmbuVKiBQRd1CMvAjHso1isu3qySDEDQetkmMnpQEvVY
         nQLg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=neutral (body hash did not verify) header.i=@gmail.com header.s=20161025 header.b=fEeKo9oQ;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org;
       dmarc=fail (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=neutral (body hash did not verify) header.i=@gmail.com header.s=20161025 header.b=fEeKo9oQ;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org;
       dmarc=fail (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751362AbeDFRmD (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Fri, 6 Apr 2018 13:42:03 -0400
Received: from mail-vk0-f68.google.com ([209.85.213.68]:43804 "EHLO
        mail-vk0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751201AbeDFRmC (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 6 Apr 2018 13:42:02 -0400
MIME-Version: 1.0
In-Reply-To: <20180405073907.30615-1-anders.roxell@linaro.org>
References: <20180308134845.32409-1-anders.roxell@linaro.org> <20180405073907.30615-1-anders.roxell@linaro.org>
From: Pintu Kumar <pintu.ping@gmail.com>
Date: Fri, 6 Apr 2018 23:12:01 +0530
Message-ID: <CAOuPNLhgAZB2w8eK4UvbtNo1mSXakpe3sKNbfSOzpoHB0iN3OA@mail.gmail.com>
Subject: Re: [PATCH v2] selftests/android/ion: fix heap_type may be uninitialized
To: Anders Roxell <anders.roxell@linaro.org>
Cc: Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kselftest-owner@vger.kernel.org
X-Mailing-List: linux-kselftest@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594377569744869523?=
X-GMAIL-MSGID: =?utf-8?q?1597019547183133098?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Apr 5, 2018 at 1:09 PM, Anders Roxell <anders.roxell@linaro.org> wr=
ote:
> gcc warns that 'heap_type' is not initialized if we don't come through
> any of the two 'case' statesments before:
>
> ionapp_export.c:91:2: warning: =E2=80=98heap_type=E2=80=99 may be used un=
initialized in
> this function [-Wmaybe-uninitialized]
>   printf("heap_type: %ld, heap_size: %ld\n", heap_type, heap_size);
>   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>
> In the current code, we initialize the heap_type to -1 before the 'case'
> statements. We also change the print_usage function to state that
> heap_type and heap_size isn't optional, they are mandatory.
>
> Fixes: 47a18c42d992 ("android/ion: userspace test utility for ion buffer =
sharing")
> Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
> ---
>  tools/testing/selftests/android/ion/ionapp_export.c | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)
>
> diff --git a/tools/testing/selftests/android/ion/ionapp_export.c b/tools/=
testing/selftests/android/ion/ionapp_export.c
> index a944e72621a9..67a0263a7f28 100644
> --- a/tools/testing/selftests/android/ion/ionapp_export.c
> +++ b/tools/testing/selftests/android/ion/ionapp_export.c
> @@ -31,8 +31,10 @@
>
>  void print_usage(int argc, char *argv[])
>  {
> -       printf("Usage: %s [-h <help>] [-i <heap id>] [-s <size in bytes>]=
\n",
> +       printf("Usage: %s [-h <help>] -i <heap id> -s <size in bytes>\n",
>                 argv[0]);
> +       printf("    Supported heap id's 0 or 1\n");
> +       printf("    Heap size > 0\n");
>  }
>
>  int main(int argc, char *argv[])
> @@ -40,7 +42,8 @@ int main(int argc, char *argv[])
>         int opt, ret, status, heapid;
>         int sockfd, client_fd, shared_fd;
>         unsigned char *map_buf;
> -       unsigned long map_len, heap_type, heap_size, flags;
> +       unsigned long map_len, heap_size, flags;
> +       long heap_type;
>         struct ion_buffer_info info;
>         struct socket_info skinfo;
>
> @@ -50,6 +53,7 @@ int main(int argc, char *argv[])
>         }
>
>         heap_size =3D 0;
> +       heap_type =3D -1;
>         flags =3D 0;
>

To make it simple, I would suggest, let the default heap_type be 0.
Actually that was my original intention but I would have missed it
during submission.
In that case nothing below is required to change.

>         while ((opt =3D getopt(argc, argv, "hi:s:")) !=3D -1) {
> @@ -68,7 +72,7 @@ int main(int argc, char *argv[])
>                                 heap_type =3D ION_HEAP_TYPE_SYSTEM_CONTIG=
;
>                                 break;
>                         default:
> -                               printf("ERROR: heap type not supported\n"=
);
> +                               print_usage(argc, argv);
>                                 exit(1);
>                         }
>                         break;
> @@ -82,8 +86,7 @@ int main(int argc, char *argv[])
>                 }
>         }
>
> -       if (heap_size <=3D 0) {
> -               printf("heap_size cannot be 0\n");
> +       if (heap_size <=3D 0 || heap_type < 0) {
>                 print_usage(argc, argv);
>                 exit(1);
>         }
> --
> 2.11.0
>

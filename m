Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752100AbeBIOwR (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Feb 2018 09:52:17 -0500
Received: from mail-qt0-f196.google.com ([209.85.216.196]:37278 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751062AbeBIOwQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Feb 2018 09:52:16 -0500
X-Google-Smtp-Source: AH8x225Fp0VmR5yQpJouezdTppoIfVe4OV7axuNx3SdoH/MiPu7imIR2jfQBi9hd/ceEYkya2DaynVwAdxX6KPZiFhY=
MIME-Version: 1.0
In-Reply-To: <CAErzpmuX+cTFseghapGdMy84Eg0SVe0niVrGdZhhpLP0uR_phQ@mail.gmail.com>
References: <CAErzpmuKgMyxascCdq3KuF1F1K4e2ciZq7FKsOha6WSBgg-WYw@mail.gmail.com>
 <CAHp75Vdm3O5xiemr-H_nF__g43pe_f-Gp6QsOoRW-DXAXrm+YQ@mail.gmail.com>
 <CAErzpmuLvx-61EtXJ=p8dqZ3r-wLSEvmsLOcUz9jzzLzAAsxUA@mail.gmail.com> <CAErzpmuX+cTFseghapGdMy84Eg0SVe0niVrGdZhhpLP0uR_phQ@mail.gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Fri, 9 Feb 2018 16:52:15 +0200
Message-ID: <CAHp75VfK=0-tzkHJj9i8Ne8WboD76xWFmn7AxUMqsaHXaf-bxw@mail.gmail.com>
Subject: Re: [PATCH v2] ASoC: use DEFINE_SHOW_ATTRIBUTE() to decrease code duplication
To: Donglin Peng <dolinux.peng@gmail.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        ALSA Development Mailing List <alsa-devel@alsa-project.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 9, 2018 at 4:43 PM, Donglin Peng <dolinux.peng@gmail.com> wrote:
> There is some duplicate code in soc-core.c, and the kernel provides
> DEFINE_SHOW_ATTRIBUTE() helper macro to decrease it in seq_file.h.
>

You missed my tag.

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Signed-off-by: Peng Donglin <dolinux.peng@gmail.com>
> ---
> v2: [addressed comments from Andy]
>  * modify code change description
>  * do not rename m -> s
> ---
>  sound/soc/soc-core.c | 45 ++++++---------------------------------------
>  1 file changed, 6 insertions(+), 39 deletions(-)
>
> diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
> index 96c44f6576c9..f372f34d7702 100644
> --- a/sound/soc/soc-core.c
> +++ b/sound/soc/soc-core.c
> @@ -349,7 +349,7 @@ static void soc_init_codec_debugfs(struct
> snd_soc_component *component)
>              "ASoC: Failed to create codec register debugfs file\n");
>  }
>
> -static int codec_list_seq_show(struct seq_file *m, void *v)
> +static int codec_list_show(struct seq_file *m, void *v)
>  {
>      struct snd_soc_codec *codec;
>
> @@ -362,20 +362,9 @@ static int codec_list_seq_show(struct seq_file *m, void *v)
>
>      return 0;
>  }
> +DEFINE_SHOW_ATTRIBUTE(codec_list);
>
> -static int codec_list_seq_open(struct inode *inode, struct file *file)
> -{
> -    return single_open(file, codec_list_seq_show, NULL);
> -}
> -
> -static const struct file_operations codec_list_fops = {
> -    .open = codec_list_seq_open,
> -    .read = seq_read,
> -    .llseek = seq_lseek,
> -    .release = single_release,
> -};
> -
> -static int dai_list_seq_show(struct seq_file *m, void *v)
> +static int dai_list_show(struct seq_file *m, void *v)
>  {
>      struct snd_soc_component *component;
>      struct snd_soc_dai *dai;
> @@ -390,20 +379,9 @@ static int dai_list_seq_show(struct seq_file *m, void *v)
>
>      return 0;
>  }
> +DEFINE_SHOW_ATTRIBUTE(dai_list);
>
> -static int dai_list_seq_open(struct inode *inode, struct file *file)
> -{
> -    return single_open(file, dai_list_seq_show, NULL);
> -}
> -
> -static const struct file_operations dai_list_fops = {
> -    .open = dai_list_seq_open,
> -    .read = seq_read,
> -    .llseek = seq_lseek,
> -    .release = single_release,
> -};
> -
> -static int platform_list_seq_show(struct seq_file *m, void *v)
> +static int platform_list_show(struct seq_file *m, void *v)
>  {
>      struct snd_soc_platform *platform;
>
> @@ -416,18 +394,7 @@ static int platform_list_seq_show(struct seq_file
> *m, void *v)
>
>      return 0;
>  }
> -
> -static int platform_list_seq_open(struct inode *inode, struct file *file)
> -{
> -    return single_open(file, platform_list_seq_show, NULL);
> -}
> -
> -static const struct file_operations platform_list_fops = {
> -    .open = platform_list_seq_open,
> -    .read = seq_read,
> -    .llseek = seq_lseek,
> -    .release = single_release,
> -};
> +DEFINE_SHOW_ATTRIBUTE(platform_list);
>
>  static void soc_init_card_debugfs(struct snd_soc_card *card)
>  {
> --
> 2.16.1



-- 
With Best Regards,
Andy Shevchenko

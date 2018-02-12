Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753993AbeBLUvK (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 15:51:10 -0500
Received: from mail-it0-f66.google.com ([209.85.214.66]:55052 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753543AbeBLUvH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 15:51:07 -0500
X-Google-Smtp-Source: AH8x224TdPl4tc7TptsK7MPV7dFjp2TSMismp12DJ+4IxGkRuDsscWxVQH2OkLxW40hjCQhjeN9DKA==
Subject: Re: [PATCH v2 4/4] of: improve reporting invalid overlay target path
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Rob Herring <robh+dt@kernel.org>,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Pantelis Antoniou <panto@antoniou-consulting.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <1518425496-12159-1-git-send-email-frowand.list@gmail.com>
 <1518425496-12159-5-git-send-email-frowand.list@gmail.com>
 <CAMuHMdUnkdtHnbSVM7p4756OQzq24N8=g8==s-6yKLAgki+LyA@mail.gmail.com>
From: Frank Rowand <frowand.list@gmail.com>
Message-ID: <a97ad5c3-eb7e-4f94-d17a-6a1a5404fb56@gmail.com>
Date: Mon, 12 Feb 2018 12:51:05 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CAMuHMdUnkdtHnbSVM7p4756OQzq24N8=g8==s-6yKLAgki+LyA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/12/18 01:00, Geert Uytterhoeven wrote:
> Hi Frank,
> 
> On Mon, Feb 12, 2018 at 9:51 AM,  <frowand.list@gmail.com> wrote:
>> From: Frank Rowand <frank.rowand@sony.com>
>>
>> Errors while developing the patch to create of_overlay_fdt_apply()
>> exposed inadequate error messages to debug problems when overlay
>> devicetree fragment nodes contain an invalid target path.  Improve
>> the messages in find_target_node() to remedy this.
>>
>> Signed-off-by: Frank Rowand <frank.rowand@sony.com>
> 
> Thanks for your patch!
> 
>> --- a/drivers/of/overlay.c
>> +++ b/drivers/of/overlay.c
>> @@ -488,17 +488,26 @@ static int build_changeset(struct overlay_changeset *ovcs)
>>   */
>>  static struct device_node *find_target_node(struct device_node *info_node)
>>  {
>> +       struct device_node *node;
>>         const char *path;
>>         u32 val;
>>         int ret;
>>
>>         ret = of_property_read_u32(info_node, "target", &val);
>> -       if (!ret)
>> -               return of_find_node_by_phandle(val);
>> +       if (!ret) {
>> +               node = of_find_node_by_phandle(val);
>> +               if (!node)
>> +                       pr_err("target node find by phandle failed\n");
> 
> Do you want to print the actual node, cfr. below?

That seems like a good idea.  The name printed below is the (short) node
name of the fragment, which seems useful.

Will do, but will remove the pointer to the node, which is more of an
internal debugging detail.


>> +               return node;
>> +       }
>>
>>         ret = of_property_read_string(info_node, "target-path", &path);
>> -       if (!ret)
>> -               return of_find_node_by_path(path);
>> +       if (!ret) {
>> +               node =  of_find_node_by_path(path);
>> +               if (!node)
>> +                       pr_err("target node find by path failed\n");
> 
> Likewise.

Will do.


>> +               return node;
>> +       }
>>
>>         pr_err("Failed to find target for node %p (%s)\n",
>>                 info_node, info_node->name);
> 
> This one prints more info.
> 
> Gr{oetje,eeting}s,
> 
>                         Geert
> 
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
> 
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds
> 

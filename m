Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86B5CECDE47
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 14:07:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49EF420827
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 14:07:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49EF420827
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727473AbeKHXn1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 18:43:27 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:33640 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726931AbeKHXn1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 18:43:27 -0500
Received: by mail-qk1-f196.google.com with SMTP id o89so26663129qko.0;
        Thu, 08 Nov 2018 06:07:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Cmq8Z0t3Y75ezhc956JefSNbsuMUAafAojsLMquh094=;
        b=IPIBXIV/ep/RDOcv3F9zFRmceMoJZqUb2X9ZrdbNcdVYeGs/3qHIfL8W04jcqIFGuW
         EIEHUcWG4rtoyq8fXBToBhqA83agjuBZFaj+woNnEXxW+5JwRs/9A8Bwky0JaFGa4dyI
         XTk6CbkEkcBg10YSsi5wyxtyJCOUGiSacYGJTCER5hIGNcpxWZktG2rGnZoALOv+uOPs
         MWzayxDYCP8IZ6wOTMfgS2/yd6DEeOmCOPhw8F++Mq+rbiWDOLoXxg8rXmbZpfj8+BSU
         W82qWPYyj97fZiWfe1lLwhFdPsWlmxjN36EuWcCnF6PHo/umUAuuf0YiY6PSMmwS6DOm
         I83g==
X-Gm-Message-State: AGRZ1gLxJxOw1hzK9hEKQ0Tk0OjwIkK8ZGrZSpcMcAcIy36T8w0zqmXt
        Xuu2nGSbyqZob6aafdkG/GgQTrL+HZKRg7fh3PA=
X-Google-Smtp-Source: AJdET5eG18D9cs1PiXm7ZSsgZXikMxz1ig9A5aZECjeCdB1mHLbOxd39CIXmFoA822IHM966WyMv9Nh4alu0O+Tl90s=
X-Received: by 2002:a0c:dc0f:: with SMTP id s15mr4426963qvk.40.1541686067792;
 Thu, 08 Nov 2018 06:07:47 -0800 (PST)
MIME-Version: 1.0
References: <20181104155501.14767-1-TheSven73@googlemail.com> <20181104155501.14767-5-TheSven73@googlemail.com>
In-Reply-To: <20181104155501.14767-5-TheSven73@googlemail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 8 Nov 2018 15:07:24 +0100
Message-ID: <CAK8P3a3DnKcRxL5dG_pvBVTngFh5eDL2JdEqZzgL0RXJy5dZGw@mail.gmail.com>
Subject: Re: [PATCH anybus v3 4/6] bus: support HMS Anybus-S bus
To:     thesven73@gmail.com
Cc:     svendev@arcx.com, Rob Herring <robh+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Lee Jones <lee.jones@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
        Thierry Reding <treding@nvidia.com>,
        David Lechner <david@lechnology.com>, noralf@tronnes.org,
        Johan Hovold <johan@kernel.org>,
        Michal Simek <monstr@monstr.eu>, michal.vokac@ysoft.com,
        gregkh <gregkh@linuxfoundation.org>,
        John Garry <john.garry@huawei.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Robin Murphy <robin.murphy@arm.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Sebastien Bourdelin <sebastien.bourdelin@savoirfairelinux.com>,
        Icenowy Zheng <icenowy@aosc.io>,
        Stuart Yoder <stuyoder@gmail.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 4, 2018 at 4:55 PM <thesven73@gmail.com> wrote:
> From: Sven Van Asbroeck <svendev@arcx.com>

> +struct anybus_mbox_hdr {
> +       u16 id;
> +       u16 info;
> +       u16 cmd_num;
> +       u16 data_size;
> +       u16 frame_count;
> +       u16 frame_num;
> +       u16 offset_high;
> +       u16 offset_low;
> +       u16 extended[8];
> +} __packed;

I don't think you want this to be __packed, it won't change the layout
but instead force byte accesses on architectures that don't have
fast unaligned load/store instructions.

Instead of the __packed, it's almost always better to ensure that
the structure itself is aligned to a 16-bit address.

> +static struct ab_task *ab_task_create_get(struct kmem_cache *cache,
> +                       ab_task_fn_t task_fn)
> +{
> +       struct ab_task *t;
> +
> +       t = kmem_cache_alloc(cache, GFP_KERNEL);
> +       if (!t)
> +               return NULL;
> +       t->cache = cache;
> +       refcount_set(&t->refcnt, 1);
> +       t->task_fn = task_fn;
> +       t->done_fn = NULL;
> +       t->result = 0;
> +       init_completion(&t->done);
> +       return t;
> +}

It looks like you build your own object management here. Maybe
use kobject, or at least kref instead of the refcount_t based
low-level implementation?

> +struct anybuss_host {
> +       struct device *dev;
> +       struct anybuss_client *client;
> +       struct reset_control *reset;
> +       struct regmap *regmap;
> +       int irq;
> +       struct task_struct *qthread;
> +       wait_queue_head_t wq;
> +       struct completion card_boot;
> +       atomic_t ind_ab;
> +       spinlock_t qlock;
> +       struct kmem_cache *qcache;
> +       struct kfifo qs[3];
> +       struct kfifo *powerq;
> +       struct kfifo *mboxq;
> +       struct kfifo *areaq;
> +       bool power_on;
> +       bool softint_pending;
> +       atomic_t dc_event;
> +       wait_queue_head_t dc_wq;
> +       atomic_t fieldbus_online;
> +       struct kernfs_node *fieldbus_online_sd;
> +};

Similarly, should that anybuss_host sturcture maybe be based on
a 'struct device' itself? What is the hierarchy of devices in sysfs?

> +
> +static int read_ind_ab(struct regmap *regmap)
> +{
> +       unsigned long timeout = jiffies + HZ/2;
> +       unsigned int a, b;
> +
> +       while (time_before_eq(jiffies, timeout)) {
> +               regmap_read(regmap, REG_IND_AB, &a);
> +               regmap_read(regmap, REG_IND_AB, &b);
> +               if (likely(a == b))
> +                       return (int)a;
> +               cpu_relax();
> +       }
> +       WARN(1, "IND_AB register not stable");
> +       return -ETIMEDOUT;
> +}

500ms is an awfully long time for a busy loop. Can you change the
cpu_relax() into a msleep() or usleep_range() to let other processes
get some time?

I see this is called from the interrupt handler at the moment, which
means you cannot call sleeping functions, but it also means that
the timeout may never happen because the timer tick IRQ cannot
get through. That means you may have to change the irq handler
logic, e.g. to try this a few times but then defer to a bottom half
if it fails for a long time.

> +/* -------------------------- mailbox tasks ----------------------- */
> +
> +struct msgAnybusInit {
> +       u16 input_io_len;
> +       u16 input_dpram_len;
> +       u16 input_total_len;
> +       u16 output_io_len;
> +       u16 output_dpram_len;
> +       u16 output_total_len;
> +       u16 op_mode;
> +       u16 notif_config;
> +       u16 wd_val;
> +} __packed;

Again, probably not __packed here.

> +static int task_fn_mbox_2(struct anybuss_host *cd, struct ab_task *t)
> +{
> +       struct mbox_priv *pd = &t->mbox_pd;
> +       unsigned int ind_ap;
> +
> +       if (!cd->power_on)
> +               return -EIO;
> +       regmap_read(cd->regmap, REG_IND_AP, &ind_ap);
> +       if (((atomic_read(&cd->ind_ab) ^ ind_ap) & IND_AX_MOUT) == 0) {
> +               /* output message not here */
> +               if (time_after(jiffies, t->start_jiffies + TIMEOUT))
> +                       return -ETIMEDOUT;
> +               return -EINPROGRESS;
> +       }

Again, avoid busy loops with long timeouts like this.

       Arnd

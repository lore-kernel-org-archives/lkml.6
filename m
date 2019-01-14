Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B36DC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 11:13:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1074E20656
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 11:13:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=jms.id.au header.i=@jms.id.au header.b="I4IWMPD1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726643AbfANLN1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 06:13:27 -0500
Received: from mail-qt1-f175.google.com ([209.85.160.175]:33641 "EHLO
        mail-qt1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726526AbfANLN1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 06:13:27 -0500
Received: by mail-qt1-f175.google.com with SMTP id l11so26056797qtp.0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jan 2019 03:13:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=svBCDBq8bWr+JrQJ41SKoxjOcMNQ6G0zJyH5TfvUZqU=;
        b=I4IWMPD1UgIPQ60krEIXBmSSpQbIOL/hoYd704xzRq8Y5l3Y1B7CFABR3La3dEAh8N
         p4q+jEw6zxuYxl70NGCUNcyNpWhklR1JEZSrrGPUKY23YGXTb5yC5ZixT7vKFnNJhX2K
         NrE4sIzAy8Z41IER6MRmJfg6M33wf9rB96wTw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=svBCDBq8bWr+JrQJ41SKoxjOcMNQ6G0zJyH5TfvUZqU=;
        b=E8RBGgo8ur7JQmSUo7wGD2VWM5LUSLnCv/DnhweXUYzC/8Y/Qywxl/L4YtfrN2Mt6k
         AXJFJ7mFuYdmSHyyjQzmWe5ZxGIa9vEIVOV1jjiDFSKSL2f0Rf2hWIeXR9XB8g3PPjU6
         PVxealZOR0uD7ldO3KLbQzHNYadkI1ryKJAOjt7Wl5ZzsjaUjmP1oBzBeaQObk6rARa8
         lRAEg6gagmyGfZwtQmCN5yU0Y3OAitNT+MM3slLQV1TURtOk8vdTcLN6cqot+wfxa7mw
         cG4pmbIP+m8bkz7RddMsuEThtLltLnWLYAmDHEeVUa+b3fT+GcCkcrg8FE6LGC26hPfq
         dFhg==
X-Gm-Message-State: AJcUukc7vrfQgD5O6aYvg6QzdF8LQ8T4oo3M4VQtGzVdTCBngcMTGcfz
        kzhnfDk5KUBrmVTuIWMJtI0LasWBhx3ISjfRB9E=
X-Google-Smtp-Source: ALg8bN7S+uW7N8MNoCNnwO5M9a565avKw8p3W45E80SBpi6+wUmVUWG7NejFmM+CbxAyRKFfKPnEazyIy7Rr04MrWkM=
X-Received: by 2002:ac8:3065:: with SMTP id g34mr23873498qte.136.1547464405416;
 Mon, 14 Jan 2019 03:13:25 -0800 (PST)
MIME-Version: 1.0
References: <20190107214136.5256-1-jae.hyun.yoo@linux.intel.com> <20190107214136.5256-4-jae.hyun.yoo@linux.intel.com>
In-Reply-To: <20190107214136.5256-4-jae.hyun.yoo@linux.intel.com>
From:   Joel Stanley <joel@jms.id.au>
Date:   Mon, 14 Jan 2019 21:43:13 +1030
Message-ID: <CACPK8XfxU6r_0HLbD2MuSgON5-G43cpENhK+SR=9KhBG4GeWDA@mail.gmail.com>
Subject: Re: [PATCH v10 03/12] peci: Add support for PECI bus driver core
To:     Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Fengguang Wu <fengguang.wu@intel.com>,
        Jason M Biils <jason.m.bills@linux.intel.com>,
        Julia Cartwright <juliac@eso.teric.us>,
        Haiyue Wang <haiyue.wang@linux.intel.com>,
        James Feist <james.feist@linux.intel.com>,
        Vernon Mauery <vernon.mauery@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Jae,

On Tue, 8 Jan 2019 at 08:11, Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com> wrote:
>
> This commit adds driver implementation for PECI bus core into linux
> driver framework.

I would like to help you get this merged next release cycle, as we are
now carrying it in OpenBMC. I suggest we ask Greg to queue it up if
there are no objections after you've addressed my questions.

> +static u8 peci_aw_fcs(u8 *data, int len)

I was wondering what aw_fcs meant. I notice that later on you describe
it as an Assure Write Frame Check Sequence byte. You could add a
comment next to this function :)

Instead of casing to u8 every time you call this, you could have this
take a struct peci_xfer_msg * and cast when calling crc8.

> +{
> +       return crc8(peci_crc8_table, data, (size_t)len, 0);
> +}
> +
> +static int __peci_xfer(struct peci_adapter *adapter, struct peci_xfer_msg *msg,
> +                      bool do_retry, bool has_aw_fcs)
> +{
> +       ktime_t start, end;
> +       s64 elapsed_ms;
> +       int rc = 0;
> +
> +       /**

These are for kerneldoc, and the comments aren't kerneldoc. Replace
them with /* instead.

> +        * For some commands, the PECI originator may need to retry a command if
> +        * the processor PECI client responds with a 0x8x completion code. In
> +        * each instance, the processor PECI client may have started the
> +        * operation but not completed it yet. When the 'retry' bit is set, the
> +        * PECI client will ignore a new request if it exactly matches a
> +        * previous valid request.
> +        */
> +
> +       if (do_retry)
> +               start = ktime_get();
> +
> +       do {
> +               rc = adapter->xfer(adapter, msg);
> +
> +               if (!do_retry || rc)
> +                       break;
> +
> +               if (msg->rx_buf[0] == DEV_PECI_CC_SUCCESS)
> +                       break;
> +
> +               /* Retry is needed when completion code is 0x8x */
> +               if ((msg->rx_buf[0] & DEV_PECI_CC_RETRY_CHECK_MASK) !=
> +                   DEV_PECI_CC_NEED_RETRY) {
> +                       rc = -EIO;
> +                       break;
> +               }
> +
> +               /* Set the retry bit to indicate a retry attempt */
> +               msg->tx_buf[1] |= DEV_PECI_RETRY_BIT;
> +
> +               /* Recalculate the AW FCS if it has one */
> +               if (has_aw_fcs)
> +                       msg->tx_buf[msg->tx_len - 1] = 0x80 ^

Can we guarantee that msg->tx_len will be set to non-zero whenever has_aw_fcs?

I suggest checking before doing the assignment in case a new caller is
added and they make a mistake.

> +static int peci_ioctl_get_dib(struct peci_adapter *adapter, void *vmsg)
> +{
> +       struct peci_get_dib_msg *umsg = vmsg;
> +       struct peci_xfer_msg msg;
> +       int rc;
> +
> +       msg.addr      = umsg->addr;
> +       msg.tx_len    = GET_DIB_WR_LEN;
> +       msg.rx_len    = GET_DIB_RD_LEN;
> +       msg.tx_buf[0] = GET_DIB_PECI_CMD;
> +
> +       rc = peci_xfer(adapter, &msg);

Most of tx_buf is going to be uninitialised. I assume a well behaving
adapter->xfer will check this and only send the correct number of
bytes, but it might pay to zero out struct peci_xfer_msg in all of
these functions?

> +       if (rc)
> +               return rc;
> +
> +       umsg->dib = le64_to_cpup((__le64 *)msg.rx_buf);
> +
> +       return 0;
> +}

> +
> +#if IS_ENABLED(CONFIG_OF)
> +static struct peci_client *peci_of_register_device(struct peci_adapter *adapter,
> +                                                  struct device_node *node)
> +{
> +       struct peci_board_info info = {};
> +       struct peci_client *result;
> +       const __be32 *addr_be;
> +       int len;
> +
> +       dev_dbg(&adapter->dev, "register %pOF\n", node);
> +
> +       if (of_modalias_node(node, info.type, sizeof(info.type)) < 0) {

I don't understand why you're doing this. Won't this always be peci,
as your binding requires?

> +               dev_err(&adapter->dev, "modalias failure on %pOF\n", node);
> +               return ERR_PTR(-EINVAL);
> +       }
> +
> +       addr_be = of_get_property(node, "reg", &len);
> +       if (!addr_be || len < sizeof(*addr_be)) {

The second check looks suspicious.

You could fix it to check the expected length (4), or use of_property_read_u32.

> +               dev_err(&adapter->dev, "invalid reg on %pOF\n", node);
> +               return ERR_PTR(-EINVAL);
> +       }
> +
> +       info.addr = be32_to_cpup(addr_be);
> +       info.of_node = of_node_get(node);
> +
> +       result = peci_new_device(adapter, &info);
> +       if (!result)

Should you do an of_node_put here?

> +               result = ERR_PTR(-EINVAL);
> +
> +       of_node_put(node);

Why do you release the reference here?

> +       return result;
> +}
> +

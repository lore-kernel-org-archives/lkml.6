Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753389AbeFATq0 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 15:46:26 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:56023 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753063AbeFATqY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 15:46:24 -0400
X-Google-Smtp-Source: ADUXVKIiTPSlbznyzn4w7AW47TID0ickjHCydzS3/2KcE+f7sLigQ69cNhxxWunI+v/rCi5VdEMluN+ryyRZYVrGEj0=
MIME-Version: 1.0
In-Reply-To: <20180601193837.GB9838@xps15>
References: <1527858967-16047-1-git-send-email-suzuki.poulose@arm.com>
 <1527858967-16047-3-git-send-email-suzuki.poulose@arm.com> <20180601193837.GB9838@xps15>
From: Mathieu Poirier <mathieu.poirier@linaro.org>
Date: Fri, 1 Jun 2018 13:46:22 -0600
Message-ID: <CANLsYkzY-1z4NBmZECczMisDixgPb2UkJL0k9_LmDNEiqUS1=g@mail.gmail.com>
Subject: Re: [RFC PATCH 2/8] coresight: Fix remote endpoint parsing
To: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Sudeep Holla <sudeep.holla@arm.com>, Rob Herring <robh@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Matt Sealey <matt.sealey@arm.com>,
        Charles Garcia-Tobin <charles.garcia-tobin@arm.com>,
        John Horley <john.horley@arm.com>, Mike Leach <mike.leach@linaro.org>,
        coresight@lists.linaro.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1 June 2018 at 13:38, Mathieu Poirier <mathieu.poirier@linaro.org> wrote:
> On Fri, Jun 01, 2018 at 02:16:01PM +0100, Suzuki K Poulose wrote:
>> When parsing the remote endpoint of an output port, we do :
>>      rport = of_graph_get_remote_port(ep);
>>      rparent = of_graph_get_remote_port_parent(ep);
>>
>> and then parse the "remote_port" as if it was the remote endpoint,
>> which is wrong. The code worked fine because we used endpoint number
>> as the port number. Let us fix it and optimise a bit as:
>>
>>      remote_ep = of_graph_get_remote_endpoint(ep);
>>      if (remote_ep)
>>         remote_parent = of_graph_get_port_parent(remote_ep);
>>
>> and then, parse the remote_ep for the port/endpoint details.
>>
>> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
>> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
>> ---
>>  drivers/hwtracing/coresight/of_coresight.c | 19 ++++++++++---------
>>  1 file changed, 10 insertions(+), 9 deletions(-)
>>
>> diff --git a/drivers/hwtracing/coresight/of_coresight.c b/drivers/hwtracing/coresight/of_coresight.c
>> index 7c37544..e0deab0 100644
>> --- a/drivers/hwtracing/coresight/of_coresight.c
>> +++ b/drivers/hwtracing/coresight/of_coresight.c
>> @@ -128,7 +128,7 @@ of_get_coresight_platform_data(struct device *dev,
>>       struct device *rdev;
>>       struct device_node *ep = NULL;
>>       struct device_node *rparent = NULL;
>> -     struct device_node *rport = NULL;
>> +     struct device_node *rep = NULL;
>>
>>       pdata = devm_kzalloc(dev, sizeof(*pdata), GFP_KERNEL);
>>       if (!pdata)
>> @@ -169,16 +169,17 @@ of_get_coresight_platform_data(struct device *dev,
>>                       pdata->outports[i] = endpoint.port;
>>
>>                       /*
>> -                      * Get a handle on the remote port and parent
>> -                      * attached to it.
>> +                      * Get a handle on the remote endpoint and the device
>> +                      * it is attached to.
>>                        */
>> -                     rparent = of_graph_get_remote_port_parent(ep);
>> -                     rport = of_graph_get_remote_port(ep);
>> -
>> -                     if (!rparent || !rport)
>> +                     rep = of_graph_get_remote_endpoint(ep);
>> +                     if (!rep)
>> +                             continue;
>> +                     rparent = of_graph_get_port_parent(rep);
>> +                     if (!rparent)
>>                               continue;
>>
>> -                     if (of_graph_parse_endpoint(rport, &rendpoint))
>> +                     if (of_graph_parse_endpoint(rep, &rendpoint))
>>                               continue;
>
> You are correct and I'm out to lunch.
>
>>
>>                       rdev = of_coresight_get_endpoint_device(rparent);
>> @@ -186,7 +187,7 @@ of_get_coresight_platform_data(struct device *dev,
>>                               return ERR_PTR(-EPROBE_DEFER);
>>
>>                       pdata->child_names[i] = dev_name(rdev);
>> -                     pdata->child_ports[i] = rendpoint.id;
>> +                     pdata->child_ports[i] = rendpoint.port;
>
> You need to do a of_node_put() here for both rep and rparent.

Same thing for the "continue" and error condition above.

>
>>
>>                       i++;
>>               } while (ep);
>> --
>> 2.7.4
>>

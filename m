Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 975C9C433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 09:12:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52C4420878
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 09:12:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52C4420878
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vosn.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728418AbeIFNqh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 09:46:37 -0400
Received: from mail.steuer-voss.de ([85.183.69.95]:55286 "EHLO
        mail.steuer-voss.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727817AbeIFNqh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 09:46:37 -0400
X-Greylist: delayed 357 seconds by postgrey-1.27 at vger.kernel.org; Thu, 06 Sep 2018 09:46:36 EDT
X-Virus-Scanned: Debian amavisd-new at mail.steuer-voss.de
Received: by mail.steuer-voss.de (Postfix, from userid 1000)
        id 7F5E747707; Thu,  6 Sep 2018 11:06:06 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by mail.steuer-voss.de (Postfix) with ESMTP id 76D3D476FB;
        Thu,  6 Sep 2018 11:06:06 +0200 (CEST)
Date:   Thu, 6 Sep 2018 11:06:06 +0200 (CEST)
From:   Nikolaus Voss <nv@vosn.de>
X-X-Sender: nv@fox.voss.local
To:     Markus Pargmann <mpa@pengutronix.de>
cc:     Mark Brown <broonie@kernel.org>, Wolfram Sang <wsa@the-dreams.de>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kernel@pengutronix.de, Irina Tirdea <irina.tirdea@intel.com>,
        nikolaus.voss@loewensteinmedical.de
Subject: Re: [PATCH v3 4/4] regmap-i2c: Add smbus i2c block support
In-Reply-To: <1440657872-24554-5-git-send-email-mpa@pengutronix.de>
Message-ID: <alpine.DEB.2.20.1809061101560.24070@fox.voss.local>
References: <1440657872-24554-1-git-send-email-mpa@pengutronix.de> <1440657872-24554-5-git-send-email-mpa@pengutronix.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha1; BOUNDARY="8323329-1313206152-1536224766=:24070"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--8323329-1313206152-1536224766=:24070
Content-Type: text/plain; charset=US-ASCII; format=flowed

Hi Markus,

On Thu, 27 Aug 2015, Markus Pargmann wrote:
> This allows to read/write up to 32 bytes of data and is to be prefered
> if supported before the register read/write smbus support.
>
> Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
> ---
> drivers/base/regmap/regmap-i2c.c | 49 ++++++++++++++++++++++++++++++++++++++++
> 1 file changed, 49 insertions(+)
>
> diff --git a/drivers/base/regmap/regmap-i2c.c b/drivers/base/regmap/regmap-i2c.c
> index 4b76e33110a2..ddb9b0efb724 100644
> --- a/drivers/base/regmap/regmap-i2c.c
> +++ b/drivers/base/regmap/regmap-i2c.c
> @@ -209,11 +209,60 @@ static struct regmap_bus regmap_i2c = {
> 	.val_format_endian_default = REGMAP_ENDIAN_BIG,
> };
>
> +static int regmap_i2c_smbus_i2c_write(void *context, const void *data,
> +				      size_t count)
> +{
> +	struct device *dev = context;
> +	struct i2c_client *i2c = to_i2c_client(dev);
> +
> +	if (count < 1)
> +		return -EINVAL;
> +	if (count >= I2C_SMBUS_BLOCK_MAX)
> +		return -E2BIG;
> +
> +	--count;
> +	return i2c_smbus_write_i2c_block_data(i2c, ((u8 *)data)[0], count,
> +					      ((u8 *)data + 1));
> +}
> +
> +static int regmap_i2c_smbus_i2c_read(void *context, const void *reg,
> +				     size_t reg_size, void *val,
> +				     size_t val_size)
> +{
> +	struct device *dev = context;
> +	struct i2c_client *i2c = to_i2c_client(dev);
> +	int ret;
> +
> +	if (reg_size != 1 || val_size < 1)
> +		return -EINVAL;
> +	if (val_size >= I2C_SMBUS_BLOCK_MAX)
> +		return -E2BIG;
> +
> +	ret = i2c_smbus_read_i2c_block_data(i2c, ((u8 *)reg)[0], val_size, val);
> +	if (ret == val_size)
> +		return 0;
> +	else if (ret < 0)
> +		return ret;
> +	else
> +		return -EIO;
> +}
> +
> +static struct regmap_bus regmap_i2c_smbus_i2c_block = {
> +	.write = regmap_i2c_smbus_i2c_write,
> +	.read = regmap_i2c_smbus_i2c_read,
> +	.max_raw_read = I2C_SMBUS_BLOCK_MAX,
> +	.max_raw_write = I2C_SMBUS_BLOCK_MAX,
> +};
> +
> static const struct regmap_bus *regmap_get_i2c_bus(struct i2c_client *i2c,
> 					const struct regmap_config *config)
> {
> 	if (i2c_check_functionality(i2c->adapter, I2C_FUNC_I2C))
> 		return &regmap_i2c;
> +	else if (config->reg_bits == 8 &&
> +		 i2c_check_functionality(i2c->adapter,
> +					 I2C_FUNC_SMBUS_I2C_BLOCK))
> +		return &regmap_i2c_smbus_i2c_block;
> 	else if (config->val_bits == 16 && config->reg_bits == 8 &&
> 		 i2c_check_functionality(i2c->adapter,
> 					 I2C_FUNC_SMBUS_WORD_DATA))
>

using i2c_smbus_read/write_i2c_block_data() instead of
read/write_word_data() or i2c_transfer() actually changes what is
transferred on the bus. SMBus block transfers have a different
register model, they additionally read or write the byte count after
transmitting the register/command code, see SMBus spec:

+---+-------------+---+--+-------------+--+---------------+--+------------+----+
| S | Slave Addr  | Wr| A| Command Code| A| Byte Count = N| A| Data Byte 1| A  |
+---+-------------+---+--+-------------+--+---------------+--+------------+----+

So a driver using regmap must implement different transfers depending on
the i2c adapter capabilities, is this intentionally done so?

Specifically, there is no way of getting rid of the additional byte count
field if the adapter doesn't support I2C_FUNC_I2C although it would be
technically possible.

I would prefer regmap to always use the same register model (i.e. without
the byte count field), can you explain the rationale for this?

Niko

--8323329-1313206152-1536224766=:24070
Content-Type: application/pkcs7-signature; name=smime.p7s
Content-Transfer-Encoding: BASE64
Content-Description: S/MIME Cryptographic Signature
Content-Disposition: attachment; filename=smime.p7s

MIINoQYJKoZIhvcNAQcCoIINkjCCDY4CAQExDzANBglghkgBZQMEAgEFADAL
BgkqhkiG9w0BBwGgggrJMIIE3zCCA8egAwIBAgIQYGqzALmCjqAD88NuNKMQ
UzANBgkqhkiG9w0BAQsFADB1MQswCQYDVQQGEwJJTDEWMBQGA1UEChMNU3Rh
cnRDb20gTHRkLjEpMCcGA1UECxMgU3RhcnRDb20gQ2VydGlmaWNhdGlvbiBB
dXRob3JpdHkxIzAhBgNVBAMTGlN0YXJ0Q29tIENsYXNzIDEgQ2xpZW50IENB
MB4XDTE2MDkwOTExNTAwN1oXDTE5MTIwOTExNTAwN1owMDETMBEGA1UEAwwK
bnZAdm9zbi5kZTEZMBcGCSqGSIb3DQEJARYKbnZAdm9zbi5kZTCCASIwDQYJ
KoZIhvcNAQEBBQADggEPADCCAQoCggEBAONBT3u4AwedL3dLnihQFF1hn0/4
99vYptx3pSw8mAOMdi7d+nDIUOIYRQUg5ylZcMGGEdN1Bps+KPntgB+wNpqV
po4ZmLsTHlNQVWE2c1XiLXzDun/X0hY0NHqSj2Xgv+C1WBFO3FRPpqp3mX0D
PyF1cKgympXb6E5w+bhmJzhWgW2466uFgu9zOLJPKrDR2sYhhLTF42F6FgnE
iITj+uDagwKv4weOdmrtTHbNia/4iFOaBD8/taKjhmAPpuBpuQxNgyd4Znt6
FWTQ91rO7BU/YD5vprcANLn5aNtQejBl/gm4gZgxH8N6G29P+PglLj6FeZkg
ZucTYllBVUEhxe0CAwEAAaOCAa4wggGqMA4GA1UdDwEB/wQEAwIEsDAdBgNV
HSUEFjAUBggrBgEFBQcDAgYIKwYBBQUHAwQwCQYDVR0TBAIwADAdBgNVHQ4E
FgQUgT5dDWr8NqTLpyvHRfq07G+hIMwwHwYDVR0jBBgwFoAUJIFsOWG+SQ+P
txtGK8kotSdIbWgwbwYIKwYBBQUHAQEEYzBhMCQGCCsGAQUFBzABhhhodHRw
Oi8vb2NzcC5zdGFydHNzbC5jb20wOQYIKwYBBQUHMAKGLWh0dHA6Ly9haWEu
c3RhcnRzc2wuY29tL2NlcnRzL3NjYS5jbGllbnQxLmNydDA4BgNVHR8EMTAv
MC2gK6AphidodHRwOi8vY3JsLnN0YXJ0c3NsLmNvbS9zY2EtY2xpZW50MS5j
cmwwFQYDVR0RBA4wDIEKbnZAdm9zbi5kZTAjBgNVHRIEHDAahhhodHRwOi8v
d3d3LnN0YXJ0c3NsLmNvbS8wRwYDVR0gBEAwPjA8BgsrBgEEAYG1NwECBTAt
MCsGCCsGAQUFBwIBFh9odHRwczovL3d3dy5zdGFydHNzbC5jb20vcG9saWN5
MA0GCSqGSIb3DQEBCwUAA4IBAQAtE8S57y3K7EgclJmX7PEkuhAAjU/Tg3f4
fFJ/BExCIDNofc2C8A20QTNVVp1/Zm7Lz+OJX36JRUo2q9NjIYaJ2Vdmpq2a
qg1fVZz4LJcHl1pVCS636CjpEmgr9eQuuh0DpmpvG1kBagsuoQvqJ2DXmIh3
iD1BvO7z+JF66Gy4GHbcfoA9G/a/blqkHVFpe+2O7O6rtXhxwFrP8fBXCCXZ
4dB9MXYcTiKvglM/tZr1FtpywtfozDNnS3795uP17V+8WXRMmA6zGrcAcaWS
fS7Is5ugGz3IPnysmSum4KNO9ofnWRI3GZB7UxuBEFIgB0bx0T7KaYnfsp8N
fwd+MOtRMIIF4jCCA8qgAwIBAgIQa6eKfQrXiNZRCvlZ5Oe04TANBgkqhkiG
9w0BAQsFADB9MQswCQYDVQQGEwJJTDEWMBQGA1UEChMNU3RhcnRDb20gTHRk
LjErMCkGA1UECxMiU2VjdXJlIERpZ2l0YWwgQ2VydGlmaWNhdGUgU2lnbmlu
ZzEpMCcGA1UEAxMgU3RhcnRDb20gQ2VydGlmaWNhdGlvbiBBdXRob3JpdHkw
HhcNMTUxMjE2MDEwMDA1WhcNMzAxMjE2MDEwMDA1WjB1MQswCQYDVQQGEwJJ
TDEWMBQGA1UEChMNU3RhcnRDb20gTHRkLjEpMCcGA1UECxMgU3RhcnRDb20g
Q2VydGlmaWNhdGlvbiBBdXRob3JpdHkxIzAhBgNVBAMTGlN0YXJ0Q29tIENs
YXNzIDEgQ2xpZW50IENBMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKC
AQEAvX3a98OifYP2W4L921tfrh4bdcC1Ga+YJKy7V3nYNewJHnzMlBsK0Hb8
Dm4Wo3FZpylcYa1MJGT10QMGWaLER3xCIuRR+8eklf/EqeZWRLojJ7zBRtjM
ywPOCelrOU+DX12dKp+Ez4J6919rz1UudTO1GvZyCYJ/I7062uHsskM8b7gP
xmcCoO1UHwwpgkvpCArJWGFoFzjLdsZbErJcS3HtAhlkbE/BKTMrdYg35Uo1
2SLBO5tbk8h2imbKTC8iMs+pskrvI/AVlh6QoTTXk6xboVX6zgMgzxSVVLym
QiygYYm0y5aMsvi2raFhC643SOGvErWWPPnSEfbeAD1xswIDAQABo4IBZDCC
AWAwDgYDVR0PAQH/BAQDAgEGMB0GA1UdJQQWMBQGCCsGAQUFBwMCBggrBgEF
BQcDBDASBgNVHRMBAf8ECDAGAQH/AgEAMDIGA1UdHwQrMCkwJ6AloCOGIWh0
dHA6Ly9jcmwuc3RhcnRzc2wuY29tL3Nmc2NhLmNybDBmBggrBgEFBQcBAQRa
MFgwJAYIKwYBBQUHMAGGGGh0dHA6Ly9vY3NwLnN0YXJ0c3NsLmNvbTAwBggr
BgEFBQcwAoYkaHR0cDovL2FpYS5zdGFydHNzbC5jb20vY2VydHMvY2EuY3J0
MB0GA1UdDgQWBBQkgWw5Yb5JD4+3G0YrySi1J0htaDAfBgNVHSMEGDAWgBRO
C+8apEBbpRdphzDKNGhD0EGu8jA/BgNVHSAEODA2MDQGBFUdIAAwLDAqBggr
BgEFBQcCARYeaHR0cDovL3d3dy5zdGFydHNzbC5jb20vcG9saWN5MA0GCSqG
SIb3DQEBCwUAA4ICAQCL4/eH7AGLhK0PAQJbnOEjJyMEvTTwcAJuUh/bodjQ
l06u4putYOxdSyIjSP/sKt+31LmjG8+IO1WqykE4H/Lm7NKezWVnCHuwb3pt
gFmlwbMbGkU2MOZBtwzfKXdYUhFLhaE2uw5jXhXvLYitQay962wP5uPI6eAI
hV4L8aaya1u4s7MnrTq0Rz25FuGNO79vTHYWj797tSRC8rM16js4yGKOLFpQ
vIg0F8IElv57b1stp+C7omqM5Qn15dePbSnqr8Jb65WtmJJbnv6rlqfY/aLu
E/zmNAlzLmPgfMDStKIXdg+EoYBZTEo8wBUaBxihfNbJ069ndQOxMNNqBelE
MgpAtmjTbCuXFjqIwWq+XOx6ZV/Wh2FAmaLsSHlNvEjjSQMZwE4EeHCdo66Z
mEs/5JYlCeOkulKVQ6P3m5/XOj2jP17Q2AgmjP+11+sHN7PvrG0OwrQp9QMe
3X+rn0G8MjtFfqBWvR9CgLIxzM3MJNxFdgdjS2rYnShP5uxvqwfZvhZVYCIk
qdJhpYON0DvSodfiar0wiM79mySZJjzC0CTbiisBzS/BeBhqeo2wFfli/iw3
hn1XKvAx0ty6w/scmBF0AYqmRHYj1TjMSw0lAl7AztLglqWjUPI+sukvadMR
PxmtKXlS2nVR4an/Z16imsZ69+fFYH68c1CK7zmjozGCApwwggKYAgEBMIGJ
MHUxCzAJBgNVBAYTAklMMRYwFAYDVQQKEw1TdGFydENvbSBMdGQuMSkwJwYD
VQQLEyBTdGFydENvbSBDZXJ0aWZpY2F0aW9uIEF1dGhvcml0eTEjMCEGA1UE
AxMaU3RhcnRDb20gQ2xhc3MgMSBDbGllbnQgQ0ECEGBqswC5go6gA/PDbjSj
EFMwDQYJYIZIAWUDBAIBBQCggeQwGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEH
ATAcBgkqhkiG9w0BCQUxDxcNMTgwOTA2MDkwNjA2WjAvBgkqhkiG9w0BCQQx
IgQg7S0u68ICjWhrwKX5SpEXbtgCMq9fJjNhIUynEYNFb78weQYJKoZIhvcN
AQkPMWwwajALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQB
AjAKBggqhkiG9w0DBzAOBggqhkiG9w0DAgICAIAwDQYIKoZIhvcNAwICAUAw
BwYFKw4DAgcwDQYIKoZIhvcNAwICASgwDQYJKoZIhvcNAQEBBQAEggEAE50g
YC229V/WKw8ooZsUTUW3oFiSXQygArCVVcG+wXWNIOEAie+/Vfs9W78/Q97c
y9Z1TZ1U6LoQ922jfnGH4s5r6pStJ4evIX1cg89Ik+1aYoViLnnB9HtuP2g7
L20T6hJTgdvshln+LyHdxpckuci2Ro3wWmvUPXESqe0++hMf+oOub5vD9cfK
PqOQpPUzA9EXNO/NOBEK9jmhMKrfp/+o1JoGmGDzXaidzrGvZCZ848/Ff0Cu
CRd5fEC9Iu8k3lETidqXAnqQu09PRqWNRB3UcC6ACSl5puHZ/f/Y+io/2ozS
mRY+mMpbIj3TBi8xu7cwTZAmZO/dHgNnxyFSEA==

--8323329-1313206152-1536224766=:24070--


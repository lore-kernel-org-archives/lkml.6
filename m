Return-Path: <foo00@h08.hostsharing.net>
X-Google-Smtp-Source: AB8JxZqibleloTmVVat87XGdSuf3LG6yYF+SrL/i8m+y6FN7jn6T8RlwnsHbMPn8uQm+qI2rPyK1
ARC-Seal: i=1; a=rsa-sha256; t=1526300298; cv=none;
        d=google.com; s=arc-20160816;
        b=dSgPCSP+vaoLoF24SQlOifvX8cMXQKNKrSjHtE+TlPirHJsQ8b0jH+aWuFhnfmn7z0
         VpLGNn1NBrmiN/qXyuHY4TwGVd0nfq6/rNzM5RyXz676XAWQy0RkxRZsiCrI7GybD9s+
         VuT11EcyRftSxu/Kkw49H9BcbcBw0ulffTlIaq5eS6kDELVeaPSne5aFSagF+JHgdAv1
         Es/Y3uFm6a6onIhYxNKbHx6aO7bKDTJLjNJ1jufv//0f56Xt9VmfRdSN+IZG83ZIM+oE
         tOfdhHqCI7b6UnmsP4POPPyvahVnGauTrNlTeXoYy3xF+QJQFWFFYubQxi9s/a8aXZBv
         ah2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=TA24t/eaGEsU1g3O7C6JeYjjvqfrAWx7wiD4/S7BK/g=;
        b=nZdm9lqWJZeuXi+uGeasq7kYquw/ojj0Nz+3rP4qrl3rxh4yPgkL/GC2n65Dhtnkt/
         XQa7OwU5IE3hSeqDBfcsuYkGdiOuIMbAxLWy0FOckwPdLUl66hP4DP902O9rslbyMK8V
         39/rV3R1dH5CraxGcEXquH/FwXbgBIBZJeOrYFDMRexjofRnYhO7gwN1k3W7hGwJclc2
         i0I0FrmD+vA8LykSd/nyJaXUXWiSVZGtiol/W5haLAYw08obd+3ZfRGmZMSKmYKP/6fG
         9e6u17t6HdssDtoR82bb40NI1ZGimmEqzpsmB85oyaaioxKDk8Eyt8t84e5SfTTskQi5
         calw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of foo00@h08.hostsharing.net designates 83.223.95.100 as permitted sender) smtp.mailfrom=foo00@h08.hostsharing.net
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of foo00@h08.hostsharing.net designates 83.223.95.100 as permitted sender) smtp.mailfrom=foo00@h08.hostsharing.net
Date: Mon, 14 May 2018 14:18:17 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org,
	Ard Biesheuvel <ard.biesheuvel@linaro.org>,
	linux-efi@vger.kernel.org,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	"Rafael J . Wysocki" <rjw@rjwysocki.net>,
	ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Subject: Re: [PATCH v2] device property: Get rid of union aliasing
Message-ID: <20180514121817.GA27869@wunner.de>
References: <20180508131547.44366-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180508131547.44366-1-andriy.shevchenko@linux.intel.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599901902158233534?=
X-GMAIL-MSGID: =?utf-8?q?1600441861581307301?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, May 08, 2018 at 04:15:47PM +0300, Andy Shevchenko wrote:
> --- a/drivers/firmware/efi/apple-properties.c
> +++ b/drivers/firmware/efi/apple-properties.c
> @@ -13,6 +13,9 @@
>   *
>   * You should have received a copy of the GNU General Public License
>   * along with this program; if not, see <http://www.gnu.org/licenses/>.
> + *
> + * FIXME: The approach is still based on union aliasing and should be
> + * replaced by a proper resource provider.

Why?  All Apple EFI properties are either boolean or u8 arrays.
You've correctly changed this file to always supply u8 arrays,
so I don't see where union aliasing is happening here?

Thanks,

Lukas

>   */
>  
>  #define pr_fmt(fmt) "apple-properties: " fmt
> @@ -96,12 +99,13 @@ static void __init unmarshal_key_value_pairs(struct dev_header *dev_header,
>  		entry[i].name = key;
>  		entry[i].length = val_len - sizeof(val_len);
>  		entry[i].is_array = !!entry[i].length;
> -		entry[i].pointer.raw_data = ptr + key_len + sizeof(val_len);
> +		entry[i].type = DEV_PROP_U8;
> +		entry[i].pointer.u8_data = ptr + key_len + sizeof(val_len);
>  
>  		if (dump_properties) {
>  			dev_info(dev, "property: %s\n", entry[i].name);
>  			print_hex_dump(KERN_INFO, pr_fmt(), DUMP_PREFIX_OFFSET,
> -				16, 1, entry[i].pointer.raw_data,
> +				16, 1, entry[i].pointer.u8_data,
>  				entry[i].length, true);
>  		}
>  
